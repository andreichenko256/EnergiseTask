import UIKit
import SnapKit

final class LaunchViewController: UIViewController {
    
    var launchView: LaunchView {
        return view as! LaunchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchView.animateLaunch()
        handleAnimationComletion()
    }
    
    override func loadView() {
        view = LaunchView()
    }
}

private extension LaunchViewController {
    func handleAnimationComletion() {
        launchView.onAnimationCompleted = {
            let tabBarVC = UINavigationController(rootViewController: CustomTabBarViewController())
            self.setRootController(tabBarVC)
        }
    }
}
