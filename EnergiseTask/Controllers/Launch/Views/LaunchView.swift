import UIKit
import SnapKit

final class LaunchView: UIView {
    
    var onAnimationCompleted: (() -> Void)?
    
    lazy var logoImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(resource: .logo).withRenderingMode(.alwaysTemplate)
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LaunchView {
    func setupUI() {
        setupMainGradient()
    }
    
    func setupConstraints() {
        [logoImageView].forEach {
            addSubview($0)
        }
        
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension LaunchView {
    func animateLaunch() {
        self.pulseLogo(repeatCount: 3) {
            self.onAnimationCompleted?()
        }
    }
    
    private func pulseLogo(repeatCount: Int, completion: @escaping () -> Void) {
        guard repeatCount > 0 else {
            UIView.animate(withDuration: 0.4, animations: {
                self.logoImageView.transform = .identity
            }, completion: { _ in
                completion()
            })
            return
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            UIView.animate(withDuration: 0.6, animations: {
                self.logoImageView.transform = .identity
            }) { _ in
                self.pulseLogo(repeatCount: repeatCount - 1, completion: completion)
            }
        }
    }
}

