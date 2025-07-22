import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    var settingsView: SettingsView {
        return view as! SettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = SettingsView()
    }
}

private extension SettingsViewController {
    
}
