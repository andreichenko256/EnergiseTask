import UIKit
import SnapKit

final class ChatView: MainView {

    var inputBarConstraint: Constraint?
    
    lazy var inputBarView = InputBarView()
    
    override init(titleName: String) {
        super.init(titleName: titleName)
        
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
        [inputBarView].forEach {
            addSubview($0)
        }
        
        inputBarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            inputBarConstraint = $0.bottom.equalToSuperview().inset(32).constraint
        }
    }
}
