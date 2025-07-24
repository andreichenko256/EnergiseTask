import UIKit
import SnapKit

final class ChatHistoryCell: UITableViewCell {
    static let reuseIdentifier = "ChatHistoryCell"
    var onDeleteButtonTapped: (() -> Void)?
    var onOpenChatButtonTapped: (() -> Void)?
    
    lazy var containerView: UIView = {
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    lazy var deleteButton: UIButton = {
        $0.setTitle(NSLocalizedString("delete", comment: ""), for: .normal)
        $0.setTitleColor(.systemRed, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var openChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("open", comment: ""), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(openChatButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var chatTitleLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    lazy var timestampLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    lazy var firstMessageLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChatHistoryCell {
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
        
        [chatTitleLabel, timestampLabel, firstMessageLabel, deleteButton, openChatButton].forEach {
            containerView.addSubview($0)
        }
        
        chatTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-8)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.leading.lessThanOrEqualTo(timestampLabel.snp.trailing)
        }
        
        openChatButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-12)
        }
        
        timestampLabel.snp.makeConstraints {
            $0.top.equalTo(chatTitleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        firstMessageLabel.snp.makeConstraints {
            $0.top.equalTo(timestampLabel.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    @objc private func deleteButtonTapped() {
        onDeleteButtonTapped?()
    }

    @objc private func openChatButtonTapped() {
        onOpenChatButtonTapped?()
    }
}

extension ChatHistoryCell {
    func configure(title: String, timestamp: Date, message: String) {
        chatTitleLabel.text = title
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        timestampLabel.text = formatter.string(from: timestamp)
        firstMessageLabel.text = message
    }
}
