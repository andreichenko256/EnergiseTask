import UIKit
import SnapKit

final class CustomTabBarView: UIView {
    var onTabSelected: ((TabView) -> Void)?
    
    let chatTab: TabView = .init(title: NSLocalizedString("chat", comment: ""), imageName: "bubble.left.and.bubble.right.fill")
    let locationTab: TabView = .init(title: NSLocalizedString("location", comment: ""), imageName: "location.fill")
    let historyTab: TabView = .init(title: NSLocalizedString("history", comment: ""), imageName: "clock.fill")
    let settingsTab: TabView = .init(title: NSLocalizedString("settings", comment: ""), imageName: "gearshape.fill")
    
    lazy var contentView: UIView = {
         $0.backgroundColor = .clear
         return $0
     }(UIView())
    
    lazy var containerView: UIView = {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    lazy var tabsHStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 40
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first?.frame = bounds
    }
}

private extension CustomTabBarView {
    func setupUI() {
        setupTabsHStackView()
        setupMainGradient()
    }
    
    func setupConstraints() {
        [containerView, tabsHStackView, contentView].forEach {
            addSubview($0)
        }
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(64)
        }
        
        tabsHStackView.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.horizontalEdges.equalTo(containerView).inset(16)
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.top)
        }
    }
    
    func setupTabsHStackView() {
        [chatTab, locationTab, historyTab, settingsTab].forEach { tab in
            tab.onTap = { [weak self] in
                self?.onTabSelected?(tab)
            }
            tabsHStackView.addArrangedSubview(tab)
        }
    }
}

extension CustomTabBarView {
    func setActiveTab(_ selectedTab: Tabs) {
        let tabs: [(Tabs, TabView)] = [
            (.chat, chatTab),
            (.location, locationTab),
            (.history, historyTab),
            (.settings, settingsTab)
        ]
        
        for (tab, view) in tabs {
            let isSelected = tab == selectedTab
            UIView.transition(with: view.imageView, duration: 0.2, options: .transitionCrossDissolve) {
                view.imageView.tintColor = isSelected ? .yellow : UIColor.lightGray
            }
            
            UIView.transition(with: view.titleLabel, duration: 0.2, options: .transitionCrossDissolve) {
                view.titleLabel.textColor = isSelected ? .yellow : UIColor.lightGray
            }
            view.isUserInteractionEnabled = !isSelected
        }
    }
}
