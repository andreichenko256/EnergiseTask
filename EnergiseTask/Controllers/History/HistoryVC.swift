import UIKit
import SnapKit

final class HistoryViewController: UIViewController {
    
    var historyView: HistoryView {
        return view as! HistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = HistoryView(titleName: "History")
    }
}

private extension HistoryViewController {
    
}
