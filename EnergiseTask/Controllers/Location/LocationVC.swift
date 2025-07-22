import UIKit
import SnapKit

final class LocationViewController: UIViewController {
    
    var locationView: LocationView {
        return view as! LocationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = LocationView()
    }
}

private extension LocationViewController {
    
}
