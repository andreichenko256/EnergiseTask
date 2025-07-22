import UIKit
import SnapKit

final class ChatView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChatView {
    func setupUI() {
        
    }
    
    func setupConstraints() {
        [].forEach {
            addSubview($0)
        }
    }
}
