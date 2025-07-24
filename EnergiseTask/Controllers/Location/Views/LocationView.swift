import UIKit
import SnapKit
import MapKit

final class LocationView: MainView {
    
    lazy var mapView: MKMapView = {
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.showsUserLocation = true
        return $0
    }(MKMapView())
    
    lazy var getDataButton: PrimaryButton = {
        $0.isDisabled = false
        return $0
    }(PrimaryButton(buttonTitleText: NSLocalizedString("get data from api", comment: "")))
    
    lazy var geoScrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = true
        $0.alwaysBounceVertical = true
        $0.backgroundColor = UIColor(white: 0.95, alpha: 1)
        $0.layer.cornerRadius = 16
        return $0
    }(UIScrollView())
    
    lazy var errorFetchingDataLabel: UILabel = {
        $0.text = "Error fetching data"
        $0.font = UIFont.systemFont(ofSize: 27)
        $0.textColor = .red
        $0.textAlignment = .center
        $0.isHidden = true
        return $0
    }(UILabel())
    
    lazy var geoDataTextView: UITextView = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.textColor = .darkGray
        $0.backgroundColor = UIColor(white: 0.95, alpha: 1)
        $0.layer.cornerRadius = 8
        $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return $0
    }(UITextView())
    
    override init(titleName: String) {
        super.init(titleName: titleName)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LocationView {
    func setupConstraints() {
        [mapView, geoScrollView, getDataButton].forEach {
            addSubview($0)
        }
        
        [geoDataTextView, errorFetchingDataLabel].forEach {
            geoScrollView.addSubview($0)
        }
        
        mapView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        geoScrollView.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        getDataButton.snp.makeConstraints {
            $0.top.equalTo(geoScrollView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        geoDataTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorFetchingDataLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
