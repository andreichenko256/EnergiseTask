import UIKit

enum SettingsFactory {
    static func make() -> [Setting] {
        return [
            .init(
                title: NSLocalizedString("rate app", comment: ""),
                imageName: "star.fill", type: .rateUs),
            .init(
                title: NSLocalizedString("share app", comment: ""),
                imageName: "square.and.arrow.up", type: .shareApp),
            .init(
                title: NSLocalizedString("contact us", comment: ""),
                imageName: "envelope", type: .contactUs)
        ]
    }
}
