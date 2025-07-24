import UIKit
import SnapKit

final class PrimaryButton: UIButton {
    
    var onButtonTapped: VoidBlock?
    
    var isDisabled: Bool = false {
        didSet {
            isEnabled = !isDisabled
            updateDisabledStateButtonUI()
        }
    }
    
    init(buttonTitleText: String) {
        super.init(frame: .zero)
        setTitle(buttonTitleText, for: .normal)
        setupGestureRecognizer()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PrimaryButton {
    func setupUI() {
        titleLabel?.font = K.Fonts.alexandriaH4
        backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        layer.cornerRadius = 16
        isEnabled = false
        snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer))
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTapGestureRecognizer() {
        onButtonTapped?()
    }
    
    func updateDisabledStateButtonUI() {
        alpha = isDisabled ? 0.5 : 1
    }
}
