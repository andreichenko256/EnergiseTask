import UIKit
import CoreLocation

final class PermisionManager {
    static let shared = PermisionManager()
    private init() {}
    
    private func openSystemSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        UIApplication.shared.open(settingsUrl)
    }
    
    func showDeniedLocationAlert(for viewController: UIViewController) {
        let alert = UIAlertController(title: "Location Access Denied", message: "To determine your location, please allow location access in Settings.", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            self.openSystemSettings()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        viewController.present(alert, animated: true)
    }
}
