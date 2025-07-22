import UIKit
import SnapKit

final class LocationView: MainView {

    
    override init(titleName: String) {
        super.init(titleName: titleName)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LocationView {
    func setupUI() {
        
    }
    
    func setupConstraints() {
        [].forEach {
            addSubview($0)
        }
    }
}
