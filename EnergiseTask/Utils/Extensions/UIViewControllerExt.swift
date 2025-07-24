import UIKit
import StoreKit

extension UIViewController {
    
    func shareAction(_ urlString: String) {
        let items: [Any] = [urlString]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    func openUrl(_ urlString: String){
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
