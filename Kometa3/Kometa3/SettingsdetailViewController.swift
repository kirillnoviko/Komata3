import UIKit

class SettingsdetailViewController: BaseViewControllerMainButton {
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var labelLanguageChange: UILabel!
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var labelChangeRussian: UIButton!
    @IBOutlet weak var labelChangeEnglish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            t.constant = 70
            r.constant = 170
            b.constant = -70
            l.constant = 170
        }else{
            t.constant = 0
            r.constant = 0
            b.constant = 0
            l.constant = 0

        }
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePage.textColor = gradientColor
        }
        
        configureUI()
        
        
       }
    
    private func configureUI() {
        buttonBack.setTitle(NSLocalizedString("buttonBackTitleStack", comment: "Текст для кнопки назад"), for: .normal)
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        
        labelChangeRussian.setTitle(NSLocalizedString("RUSSIAN", comment: "Текст для кнопки назад"), for:.normal)
        labelChangeRussian.layer.cornerRadius = 33
        labelChangeRussian.clipsToBounds = true
        labelChangeRussian.titleLabel?.font = UIFont(name: "REM-Black", size: 43)
        
        labelChangeEnglish.setTitle(NSLocalizedString("ENGLISH", comment: "Текст для кнопки назад"), for:.normal)
        labelChangeEnglish.layer.cornerRadius = 33
        labelChangeEnglish.clipsToBounds = true
        labelChangeEnglish.titleLabel?.font = UIFont(name: "REM-Black", size: 43)
        
        titlePage.text = NSLocalizedString("titlePageSettingsChange", comment: "Заголовок страницы")
        titlePage.font = UIFont(name: "REM-Black", size: 53)
        titlePage.adjustsFontSizeToFitWidth = true
        titlePage.minimumScaleFactor = 0.5
        
        labelLanguageChange.text = NSLocalizedString("labelLanguageChangePageSettings", comment: "Подзаголовок выбора языка")
        labelLanguageChange.font = UIFont(name: "REM-Black", size: 43)
        labelLanguageChange.adjustsFontSizeToFitWidth = true
        labelLanguageChange.minimumScaleFactor = 0.5
 
        updateButtonColors()
    }

    private func updateButtonColors() {
        let currentLanguage = LanguageManager.shared.currentLanguage
        
        if currentLanguage == "ru" {
            labelChangeRussian.setTitleColor(.yellow, for: .normal)
            labelChangeEnglish.setTitleColor(.white, for: .normal)
        } else if currentLanguage == "en" {
            labelChangeEnglish.setTitleColor(.yellow, for: .normal)
            labelChangeRussian.setTitleColor(.white, for: .normal)
        }
    }

    
    @IBAction func tappedBack(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeEnglish(_ sender: Any) {
        setLanguage("en")
    }
    
    @IBAction func changeRussian(_ sender: Any) {
        setLanguage("ru")
    }
    
    private func setLanguage(_ language: String) {
        LanguageManager.shared.currentLanguage = language
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
        updateButtonColors()
        showSuccessAlert()
    }
    
    private func showSuccessAlert() {
        let successAlert = UIAlertController(
            title: NSLocalizedString("Change Language!", comment: "Успех"),
            message: NSLocalizedString("Success change language", comment: "message succes"),
            preferredStyle: .alert
        )
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let storyboard = UIStoryboard(name: "MainWindow", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            self.ParentNavigationController?.viewControllers = [mainVC]
           
        }))
        present(successAlert, animated: true)
    }
    

    
 
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
  
}

    


    



