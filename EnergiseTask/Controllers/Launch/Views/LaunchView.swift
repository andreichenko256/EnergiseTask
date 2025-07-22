import UIKit
import SnapKit

final class LaunchView: MainView {
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + K.launchTime) {
            self.onAnimationCompleted?()
        }
    }
}

