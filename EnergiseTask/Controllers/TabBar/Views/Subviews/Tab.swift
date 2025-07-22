import UIKit
import SnapKit

final class TabView: UIView {
    var onTap: (() -> Void)?
    
    lazy var containerView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    lazy var titleLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = K.Fonts.redHatP4
        return $0
    }(UILabel())
    
    init(title: String, imageName: String) {
        super.init(frame: .zero)
        imageView.image = UIImage(systemName: imageName)
        titleLabel.text = title
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabView {
    func setupConstraints(){
        
        [imageView, titleLabel].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(2)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
}

private extension TabView {
    func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(gesture)
    }
    
    @objc func handleTap() {
        onTap?()
    }
}
