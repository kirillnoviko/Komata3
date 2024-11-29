import UIKit

class LoseViewController: BaseViewControllerMainButton {
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonRestart: UIButton!
    
    @IBOutlet weak var titlePageWin: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            t.constant = 50
            r.constant = 150
            b.constant = 50
            l.constant = 150
        }else{
            t.constant = 0
            r.constant = 0
            b.constant = 0
            l.constant = 0

        }
        buttonBack.setTitle(NSLocalizedString("buttonBackTitleStack", comment: "Текст для кнопки назад"), for: .normal)
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        
        
        buttonRestart.setTitle(NSLocalizedString("buttonRestartTitleStack", comment: "Текст для кнопки назад"), for: .normal)
        buttonRestart.layer.cornerRadius = 33
        buttonRestart.clipsToBounds = true
        buttonRestart.titleLabel?.lineBreakMode = .byWordWrapping
        buttonRestart.titleLabel?.numberOfLines = 0
        buttonRestart.titleLabel?.textAlignment = .center
        buttonRestart.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        
        
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePageWin.textColor = gradientColor
        }
        titlePageWin.text = NSLocalizedString("titleLablePageLose", comment: "Заголовок страницы")
        titlePageWin.font = UIFont(name: "REM-Black", size: 63)
        titlePageWin.adjustsFontSizeToFitWidth = true
        titlePageWin.minimumScaleFactor = 0.5
        

        
        

        

    }
    

    @IBAction func tappedRestart(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
    }
    @IBAction func tappedBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainWindow", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.ParentNavigationController?.viewControllers = [mainVC]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

 
    
   


}

