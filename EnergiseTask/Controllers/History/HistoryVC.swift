import UIKit
import SnapKit

final class HistoryViewController: UIViewController {

    var chats: [Chat] = []
    
    var historyView: HistoryView {
        return view as! HistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chats = CoreDataManager.shared.fetchChats()
        historyView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        view = HistoryView(titleName: "History")
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatHistoryCell") as! ChatHistoryCell
        let chat = chats[indexPath.row]
        let title = "Chat #\(indexPath.row + 1)"
        let date = chat.createdAt ?? Date()
        let message = chat.firstMessage ?? "No message"
        cell.configure(title: title, timestamp: date, message: message)
        
        cell.onDeleteButtonTapped = { [weak self, weak tableView = self.historyView.tableView] in
            guard let self = self,
                  let tableView,
                  let currentIndexPath = tableView.indexPath(for: cell) else { return }
            
            let chat = self.chats[currentIndexPath.row]
            self.chats.remove(at: currentIndexPath.row)
            self.historyView.tableView.deleteRows(at: [currentIndexPath], with: .automatic)
            CoreDataManager.shared.deleteChat(chat)
        }
        
        cell.onOpenChatButtonTapped = { [weak self, weak tableView = self.historyView.tableView] in
            guard let self = self,
                  let tableView,
                  let currentIndexPath = tableView.indexPath(for: cell) else { return }

            let chat = self.chats[currentIndexPath.row]
            if let messages = chat.messages?.allObjects as? [Message] {
                let messageModels: [MessageModel] = messages.map {
                    MessageModel(text: $0.text ?? "", sender: $0.sender == "user" ? .user : .other)
                }
                let vc = FullChatViewController(messages: messageModels, chatName: title)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                print("No messages")
            }
        }
        
        return cell
    }
}
