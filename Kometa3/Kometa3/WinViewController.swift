import UIKit

class WinViewController: BaseViewControllerMainButton {
    
    @IBOutlet weak var buttonBack: UIButton!
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var titlePageWin: UILabel!
    @IBOutlet weak var subTitlePageWin: UILabel!
    @IBOutlet weak var codePageWin: UILabel!
    @IBOutlet weak var textPageWin: UILabel!
   
    
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
        
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePageWin.textColor = gradientColor
            self.subTitlePageWin.textColor = gradientColor
            self.codePageWin.textColor = gradientColor
            self.textPageWin.textColor = gradientColor
        }
        titlePageWin.text = NSLocalizedString("titleLablePageWin", comment: "Заголовок страницы")
        titlePageWin.font = UIFont(name: "REM-Black", size: 63)
        titlePageWin.adjustsFontSizeToFitWidth = true
        titlePageWin.minimumScaleFactor = 0.5
        
     
        subTitlePageWin.text = NSLocalizedString("subTitleLablePageWin", comment: "Заголовок страницы")
        subTitlePageWin.font = UIFont(name: "REM-Black", size: 48)
        subTitlePageWin.adjustsFontSizeToFitWidth = true
        subTitlePageWin.minimumScaleFactor = 0.5
        
       
        codePageWin.text = NSLocalizedString("codeLablePageWin", comment: "Заголовок страницы")
        codePageWin.font = UIFont(name: "REM-Black", size: 53)
        codePageWin.adjustsFontSizeToFitWidth = true
        codePageWin.minimumScaleFactor = 0.5
        
        
       
        textPageWin.text = NSLocalizedString("textLablePageWin", comment: "Заголовок страницы")
        textPageWin.font = UIFont(name: "REM-Black", size: 28)
        textPageWin.adjustsFontSizeToFitWidth = true
        textPageWin.minimumScaleFactor = 0.5
        
        

        

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

