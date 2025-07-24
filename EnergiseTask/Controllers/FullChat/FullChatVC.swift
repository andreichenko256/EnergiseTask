import UIKit
import SnapKit

final class FullChatViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var messages: [MessageModel] = []
    var chatName: String = ""
    
    init(messages: [MessageModel], chatName: String) {
        super.init(nibName: nil, bundle: nil)
        self.messages = messages
        self.chatName = chatName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fullChatView: FullChatView {
        return view as! FullChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleBackButtonTapped()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        fullChatView.fullChatTableView.dataSource = self
        fullChatView.fullChatTableView.delegate = self
    }
    
    override func loadView() {
        view = FullChatView(titleName: chatName)
    }
}

private extension FullChatViewController {
    func handleBackButtonTapped() {
        fullChatView.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension FullChatViewController: UITableViewDataSource, UITableViewDelegate {
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
}
