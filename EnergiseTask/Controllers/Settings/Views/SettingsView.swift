import UIKit
import SnapKit

final class SettingsView: MainView {
    
    lazy var tableView: UITableView = {
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        $0.backgroundColor = .clear
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 44
        $0.isScrollEnabled = false
        return $0
    }(UITableView())
    
    lazy var containerView: UIView = {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        return $0
    }(UIView())
    
    override init(titleName: String) {
        super.init(titleName: titleName)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.layoutIfNeeded()
        
        let height = tableView.contentSize.height
        containerView.snp.updateConstraints {
            $0.height.equalTo(height + 54)
        }
        
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(32)
        }
    }
}

private extension SettingsView {
    func setupConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(0)
        }
    }
}
