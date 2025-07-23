import UIKit
import SnapKit

final class OutgoingMessageCell: UITableViewCell {
    static let reuseIdentifier = "OutgoingMessageCell"
    
    lazy var messageLabel: UILabel = {
        $0.textColor = .white
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var bubbleView: UIView = {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = UIColor(red: 0/255, green: 99/255, blue: 229/255, alpha: 1)
        
        $0.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        return $0
    }(UIView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        messageLabel.text = nil
    }
}

private extension OutgoingMessageCell {
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func setupConstraints() {
        [bubbleView].forEach {
            contentView.addSubview($0)
        }
        
        bubbleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.greaterThanOrEqualToSuperview().inset(32)
        }
    }
}

extension OutgoingMessageCell {
    func configure(with message: String) {
        messageLabel.text = message
    }
}
