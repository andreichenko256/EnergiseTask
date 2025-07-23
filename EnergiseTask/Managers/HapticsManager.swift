import UIKit

final class HapticsManager {
    static let shared = HapticsManager()

    private init(){}

    public func vibrateForSendMessage(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}
