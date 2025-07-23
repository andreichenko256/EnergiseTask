import UIKit
import SnapKit

final class InputBarView: UIView {

    var currentText: String {
        inputTextField.text ?? ""
    }
    
    let sendTextButton = PrimaryButton.init(buttonTitleText: "Send")
    
    lazy var inputTextField: UITextField = {
        $0.placeholder = "Type message here..."
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        $0.backgroundColor = .lightGray
        return $0
    }(UITextField())
    
    lazy var inputTextView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 16
        view.addSubview(inputTextField)
        inputTextField.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
        }
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InputBarView {
    func setupUI() {
        sendTextButton.isDisabled = true
    }
    
    func setupConstraints() {
        [inputTextView, sendTextButton].forEach {
            addSubview($0)
        }
        
        sendTextButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(inputTextView.snp.trailing).offset(16)
            $0.width.equalToSuperview().multipliedBy(0.20)
        }
        
        inputTextView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    @objc func textFieldDidChange() {
        sendTextButton.isDisabled = currentText.isEmpty
    }
}
