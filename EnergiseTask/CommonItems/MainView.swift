import UIKit
import SnapKit

class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first?.frame = bounds
    }
}

private extension MainView {
    func setupUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = K.Colors.mainBackgroundGradientColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupConstraints() {
        [].forEach {
            addSubview($0)
        }
    }
}
