import UIKit

extension UIView {
    func setupMainGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.1, green: 0.1, blue: 0.15, alpha: 1).cgColor,
            UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 1).cgColor,
            UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
