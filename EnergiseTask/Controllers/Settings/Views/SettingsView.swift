import UIKit
import SnapKit

final class SettingsView: MainView {
    
   override init(titleName: String) {
       super.init(titleName: titleName)
       
       setupUI()
       setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsView {
    func setupUI() {
        
    }
    
    func setupConstraints() {
        [].forEach {
            addSubview($0)
        }
    }
}
