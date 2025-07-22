import UIKit
import SnapKit

final class CustomTabBarViewController: UIViewController {
    
    var customTabBarView: CustomTabBarView {
        return view as! CustomTabBarView
    }
    
    var currentVC: UIViewController?
    var tabBarTabs: [TabView: Tabs] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        handleTabSelection(tab: .chat)
        handleTabTapped()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.delegate = self
    }
    
    override func loadView() {
        view = CustomTabBarView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tabBarHeight = customTabBarView.containerView.frame.height + 16
        
        NotificationCenter.default.post(name: .tabBarHeight,
                                        object: nil,
                                        userInfo: ["height": tabBarHeight])
    }
}

private extension CustomTabBarViewController {
    func setupTabs() {
        tabBarTabs[customTabBarView.chatTab] = .chat
        tabBarTabs[customTabBarView.locationTab] = .location
        tabBarTabs[customTabBarView.historyTab] = .history
        tabBarTabs[customTabBarView.settingsTab] = .settings
    }
    
    func updateViewControllerSelection() {
        if let oldVC = children.first {
            oldVC.willMove(toParent: nil)
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParent()
        }
        
        guard let newVC = currentVC else { return }
        
        addChild(newVC)
        customTabBarView.contentView.addSubview(newVC.view)
        newVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        newVC.didMove(toParent: self)
    }
    
    func handleTabTapped() {
        customTabBarView.onTabSelected = { [weak self] tabView in
            guard let self, let selectedTab = self.tabBarTabs[tabView] else { return }
            self.handleTabSelection(tab: selectedTab)
        }
    }
}

extension CustomTabBarViewController {
    func handleTabSelection(tab: Tabs) {
        customTabBarView.setActiveTab(tab)
        
        switch tab {
        case .chat:
            currentVC = ChatViewController()
        case .location:
            currentVC = LocationViewController()
        case .history:
            currentVC = HistoryViewController()
        case .settings:
            currentVC = SettingsViewController()
        }
        
        updateViewControllerSelection()
    }
}

extension CustomTabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let enable = self.navigationController?.viewControllers.count ?? 0 > 1
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension Notification.Name {
    static let tabBarHeight = Notification.Name("tabBarHeight")
}
