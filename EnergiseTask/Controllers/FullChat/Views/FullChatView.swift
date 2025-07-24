import UIKit
import SnapKit

final class FullChatView: MainView {
    
    var onBackButtonTapped: (() -> Void)?
    
    lazy var fullChatTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: 12, left: 0, bottom: 12, right: 0)
        tableView.register(IncomingMessageCell.self, forCellReuseIdentifier: IncomingMessageCell.reuseIdentifier)
        tableView.register(OutgoingMessageCell.self, forCellReuseIdentifier: OutgoingMessageCell.reuseIdentifier)
        return tableView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(titleName: String) {
        super.init(titleName: titleName)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FullChatView {
    func setupUI() {
        backgroundColor = UIColor(red: 10/255, green: 10/255, blue: 20/255, alpha: 1)
    }
    
    func setupConstraints() {
        [fullChatTableView].forEach {
            addSubview($0)
        }
        
        addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(32)
        }
        
        fullChatTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).inset(16)
            $0.bottom.equalTo(safeBottom)
        }
    }
    
    @objc private func backButtonTapped() {
        onBackButtonTapped?()
    }
}
