import UIKit
import SnapKit

final class ChatViewController: UIViewController {
    
    let answers = UserDefaultsManager.shared.getAnswers()
    var tabBarHeight = 0.0
    
    private var messages: [MessageModel] = []
    private var currentChat: Chat?
    
    var chatView: ChatView {
        return view as! ChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addKeyboardsObservers()
        handleSendButtonTapped()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarHeight), name: .tabBarHeight, object: nil)
        chatView.chatTableView.dataSource = self
        DispatchQueue.main.async {
            self.scrollToBottom()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleTabBarHeight(_ notification: Notification) {
        if let height = notification.userInfo?["height"] as? CGFloat {
            tabBarHeight = height
        }
    }
    
    override func loadView() {
        view = ChatView(titleName: "Chat")
    }
}

private extension ChatViewController {
    func handleSendButtonTapped() {
        chatView.inputBarView.sendTextButton.onButtonTapped = { [self] in
            HapticsManager.shared.vibrateForSendMessage()
            
            let messageText = chatView.inputBarView.currentText
            messages.append(MessageModel(text: messageText, sender: .user))
            
            if currentChat == nil {
                currentChat = CoreDataManager.shared.createChat(firstMessage: messageText)
            }
            if let chat = currentChat {
                CoreDataManager.shared.addMessage(to: chat, text: messageText, sender: "user")
            }

            DispatchQueue.main.async { [self] in
                chatView.chatTableView.reloadData()
                scrollToBottom()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [self] in
                let reply = getRandomIncomingMessage()
                messages.append(MessageModel(text: reply, sender: .other))
                if let chat = currentChat {
                    CoreDataManager.shared.addMessage(to: chat, text: reply, sender: "other")
                }
                chatView.chatTableView.reloadData()
                scrollToBottom()
            })
            updateSendTextButtonStateUI()
        }
    }
    
    func updateSendTextButtonStateUI() {
        self.chatView.inputBarView.inputTextField.text = ""
        chatView.inputBarView.sendTextButton.isDisabled = true
    }
    
    func getRandomIncomingMessage() -> String {
        let randomIndex = Int.random(in: 0..<answers!.count)
        return answers![randomIndex]
    }

    func addKeyboardsObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height - tabBarHeight
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.chatView.inputBarConstraint?.update(inset: keyboardHeight)
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.chatView.inputBarConstraint?.update(inset: 32)
            self?.view.layoutIfNeeded()
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
    
        switch message.sender {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingMessageCell.reuseIdentifier, for: indexPath) as! OutgoingMessageCell
            cell.configure(with: message.text)
            return cell
        case .other:
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingMessageCell.reuseIdentifier, for: indexPath) as! IncomingMessageCell
            cell.configure(with: message.text)
            return cell
        }
    }
    
    func scrollToBottom(animated: Bool = true) {
        let numberOfSections = chatView.chatTableView.numberOfSections
        guard numberOfSections > 0 else { return }
        
        let numberOfRows = chatView.chatTableView.numberOfRows(inSection: numberOfSections - 1)
        guard numberOfRows > 0 else { return }

        let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
        chatView.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
}
