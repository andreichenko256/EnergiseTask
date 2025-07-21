import UIKit
import SnapKit

final class CustomTabBarViewController: UIViewController {
    
    var customTabBarView: CustomTabBarView {
        return view as! CustomTabBarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = CustomTabBarView()
    }
}

private extension CustomTabBarViewController {
    
}

