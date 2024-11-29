import Foundation
class OnboardingManager {
    private static let onboardingCompletedKey = "onboardingCompleted"

    static func setOnboardingCompleted() {
        UserDefaults.standard.set(true, forKey: onboardingCompletedKey)
    }

    static func isOnboardingCompleted() -> Bool {
        return UserDefaults.standard.bool(forKey: onboardingCompletedKey)
    }
}
