import UIKit
import SnapKit

final class ChatViewController: UIViewController {
    
    let answers = UserDefaultsManager.shared.getAnswers()
    var tabBarHeight = 0.0
    var chatView: ChatView {
        return view as! ChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addKeyboardsObservers()
        handleSendButtonTapped()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarHeight), name: .tabBarHeight, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleTabBarHeight(_ notification: Notification) {
        if let height = notification.userInfo?["height"] as? CGFloat {
            print("Received tab bar height: \(height)")
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
            let messageText = chatView.inputBarView.currentText
            print(messageText)
            updateSendTextButtonStateUI()
        }
    }
    
    func updateSendTextButtonStateUI() {
        self.chatView.inputBarView.inputTextField.text = ""
        chatView.inputBarView.sendTextButton.isDisabled = true
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
