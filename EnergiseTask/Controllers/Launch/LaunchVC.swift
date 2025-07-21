import UIKit
import SnapKit

final class LaunchViewController: UIViewController {
    
    var launchView: LaunchView {
        return view as! LaunchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = LaunchView()
    }
}

private extension LaunchViewController {
    
}
