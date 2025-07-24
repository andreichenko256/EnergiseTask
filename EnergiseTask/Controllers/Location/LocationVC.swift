import UIKit
import SnapKit
import MapKit

final class LocationViewController: UIViewController {
    
    var locationView: LocationView {
        return view as! LocationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleGetDataButtonTapped()
    }
    
    override func loadView() {
        view = LocationView(titleName: "Location")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocationManager.shared.requestLocationPermission(from: self)
    }
}

private extension LocationViewController {
    func handleGetDataButtonTapped() {
        locationView.getDataButton.onButtonTapped = { [self] in
            NetworkManager.shared.fetchGeoData { result in
                
                switch result {
                case .success(let data):
                    self.addAnnotation(latitude: data.lat, longitude: data.lon, title: data.city)
                    let geoInfo = """
                    IP: \(data.query)
                    Country: \(data.country) (\(data.countryCode))
                    Region: \(data.regionName)
                    City: \(data.city)
                    ZIP: \(data.zip)
                    Coordinates: \(data.lat), \(data.lon)
                    Timezone: \(data.timezone)
                    ISP: \(data.isp)
                    Organization: \(data.org)
                    AS: \(data.asDescription)
                    """
                    self.locationView.geoDataTextView.text = geoInfo
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func addAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String?) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        locationView.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        locationView.mapView.setRegion(region, animated: true)
    }
}
