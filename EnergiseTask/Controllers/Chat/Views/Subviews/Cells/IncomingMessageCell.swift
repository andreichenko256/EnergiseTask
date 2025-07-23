import UIKit
import SnapKit

final class IncomingMessageCell: UITableViewCell {
    static let reuseIdentifier = "IncomingMessageCell"
    
    lazy var messageLabel: UILabel = {
        $0.textColor = .white
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var bubbleView: UIView = {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = UIColor(red: 44/255, green: 47/255, blue: 51/255, alpha: 1)
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

private extension IncomingMessageCell {
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
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(32)
        }
    }
}

extension IncomingMessageCell {
    func configure(with message: String) {
        messageLabel.text = message
    }
}
