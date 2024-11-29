import Foundation
class LanguageManager {
    static let shared = LanguageManager()
    private let languageKey = "currentLanguage"


    var currentLanguage: String {
        get {
            UserDefaults.standard.string(forKey: "currentLanguage") ?? Locale.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentLanguage")
            UserDefaults.standard.synchronize()
            updateBundle(for: newValue)
        }
    }
    
    private func updateBundle(for language: String) {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            Bundle.localizedBundle = bundle
        } else {
            Bundle.localizedBundle = Bundle.main
        }
    }
}

extension Bundle {
    private static var _localizedBundle: Bundle?

    static var localizedBundle: Bundle {
        get {
            _localizedBundle ?? Bundle.main
        }
        set {
            _localizedBundle = newValue
        }
    }
}
func NSLocalizedString(_ key: String, comment: String) -> String {
    return Bundle.localizedBundle.localizedString(forKey: key, value: nil, table: nil)
}


