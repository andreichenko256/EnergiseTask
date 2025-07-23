import UIKit
import SnapKit

final class ChatView: MainView {
    
    var inputBarConstraint: Constraint?
    
    lazy var inputBarView = InputBarView()
    
    lazy var chatTableView: UITableView = {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        
        $0.register(OutgoingMessageCell.self, forCellReuseIdentifier: OutgoingMessageCell.reuseIdentifier)
        $0.register(IncomingMessageCell.self, forCellReuseIdentifier: IncomingMessageCell.reuseIdentifier)
        return $0
    }(UITableView())
    
    lazy var tableViewContainer: UIView = {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.addSubview(chatTableView)
        chatTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return $0
    }(UIView())
    
    override init(titleName: String) {
        super.init(titleName: titleName)
        
        setupConstraints()
        setupDissmissKeyboardGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChatView {
    func setupConstraints() {
        [inputBarView, tableViewContainer].forEach {
            addSubview($0)
        }
        
        inputBarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            inputBarConstraint = $0.bottom.equalToSuperview().inset(32).constraint
        }
        
        tableViewContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(inputBarView.snp.top).offset(-16)
        }
    }
    
    func setupDissmissKeyboardGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}
