import UIKit
import SnapKit

final class HistoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HistoryView {
    func setupUI() {
        backgroundColor = .red
    }
    
    func setupConstraints() {
        [].forEach {
            addSubview($0)
        }
    }
}
