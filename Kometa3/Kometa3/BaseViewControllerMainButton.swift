
import UIKit

class BaseViewControllerMainButton: UIViewController {
    weak var ParentNavigationController: UINavigationController?
    override func viewDidLoad() {
          super.viewDidLoad()
    
          NotificationCenter.default.addObserver(
              self,
              selector: #selector(updateLocalizedText),
              name: .languageDidChange,
              object: nil
          )
      }
      
      deinit {
      
          NotificationCenter.default.removeObserver(self, name: .languageDidChange, object: nil)
      }

      @objc func updateLocalizedText() {
          
      }
}
