import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    let settings = SettingsFactory.make()
    
    var settingsView: SettingsView {
        return view as! SettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self
    }
    
    override func loadView() {
        view = SettingsView(titleName: "Settings")
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier) as! SettingCell
        let setting = settings[indexPath.row]
        cell.configure(setting: setting)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let setting = settings[indexPath.row]
        UIView.animate(withDuration: 0.1,
                       animations: {
            cell.contentView.alpha = 0.5
        }, completion: { _ in
            UIView.animate(withDuration: 0.1,
                           animations: {
                cell.contentView.alpha = 1.0
            }, completion: { _ in
                switch setting.type {
                case .rateUs:
                    print("rate uss")
                case .shareApp:
                    print("share app")
                case .contactUs:
                    print("contact us")
                }
            })
        })
        
    }
}
