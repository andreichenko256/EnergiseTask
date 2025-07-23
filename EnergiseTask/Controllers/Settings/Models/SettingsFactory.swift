enum SettingsFactory {
    static func make() -> [Setting] {
        return [
            .init(
                title: "Rate App",
                imageName: "star.fill", type: .rateUs),
            .init(
                title: "Share App",
                imageName: "square.and.arrow.up", type: .shareApp),
            .init(
                title: "Contact Us",
                imageName: "envelope", type: .contactUs)
        ]
    }
}
