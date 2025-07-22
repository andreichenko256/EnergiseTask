import UIKit
import SnapKit

class MainView: UIView {
    
    lazy var titleLabel: UILabel = {
        $0.font = K.Fonts.alexandriaH2
        $0.textColor = K.Colors.primaryColor
        return $0
    }(UILabel())
    
    init(titleName: String) {
        super.init(frame: .zero)
        titleLabel.text = titleName
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainView {
    func setupUI() {
        
    }
    
    func setupConstraints() {
        [titleLabel].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeTop).inset(16)
        }
    }
}
