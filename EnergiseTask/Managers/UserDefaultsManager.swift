import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    private enum Keys  {
        static let answers = "answers"
    }
}

private extension UserDefaultsManager {
    func setAnswers() {
        UserDefaults.standard.set(K.answers, forKey: Keys.answers)
    }
}

extension UserDefaultsManager {
    func getAnswers() -> [String]? {
        setAnswers()
        return UserDefaults.standard.stringArray(forKey: Keys.answers)
    }
}
