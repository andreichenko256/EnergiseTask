import UIKit
import SnapKit

final class SettingCell: UITableViewCell {
    static let reuseIdentifier = "SettingCell"
    
    lazy var containerView: UIView = {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    lazy var titleLabel: UILabel = {
        $0.font = K.Fonts.redHatP1
        $0.textColor = .white
        return $0
    }(UILabel())
    
    lazy var iconImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = K.Colors.secondaryColor
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingCell {
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func setupConstraints() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        [iconImageView, titleLabel].forEach {
            containerView.addSubview($0)
        }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}

extension SettingCell {
    func configure(setting: Setting) {
        titleLabel.text = setting.title
        iconImageView.image = UIImage(systemName: setting.imageName)
    }
}
