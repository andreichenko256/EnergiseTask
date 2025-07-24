import UIKit
import SnapKit

final class HistoryView: MainView {
    
    lazy var tableView: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.register(ChatHistoryCell.self, forCellReuseIdentifier: ChatHistoryCell.reuseIdentifier)
        return $0
    }(UITableView())
    
    override init(titleName: String) {
        super.init(titleName: titleName)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HistoryView {
    func setupConstraints() {
        [tableView].forEach {
            addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
