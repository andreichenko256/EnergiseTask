import Foundation
import CoreLocation
import UIKit

final class LocationManager: NSObject {

    private let locationManager = CLLocationManager()
    
    static let shared = LocationManager()
    
    private override init() {
        super.init()
    }
    
    func requestLocationPermission(from viewController: UIViewController? = nil) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            if let vc = viewController {
                PermisionManager.shared.showDeniedLocationAlert(for: vc)
            }
            print("Location permission denied")
        case .authorizedWhenInUse, .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
}
