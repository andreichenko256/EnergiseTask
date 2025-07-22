import UIKit
import SnapKit

final class ChatViewController: UIViewController {
    
    var chatView: ChatView {
        return view as! ChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = ChatView()
    }
}

private extension ChatViewController {
    
}
