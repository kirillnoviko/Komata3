

import UIKit

class QRCodePageViewController: BaseViewControllerMainButton {
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    @IBOutlet weak var buttonBack: UIButton!
   @IBOutlet weak var titlePage: UILabel!

    @IBOutlet weak var subtitlePage: UILabel!
    
    
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
        buttonBack.setTitle(NSLocalizedString("buttonBackTitle", comment: "Текст для кнопки назад"), for: .normal )
   
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 25)
        
        if let gradientColor = GradientTextHelper.gradientColor(bounds: CGRect(x: 0, y: 0, width: titlePage.frame.width, height: 100)) {
            titlePage.textColor = gradientColor
            
        }
        titlePage.text  = NSLocalizedString("titleQRPage", comment: "Не удалось сохранить заказ")
        titlePage.font = UIFont(name: "REM-Black", size: 33)
        titlePage.adjustsFontSizeToFitWidth = true
        titlePage.minimumScaleFactor = 0.5
        
        if let gradientColor1 = GradientTextHelper.gradientColor(bounds: CGRect(x: 0, y: 0, width: subtitlePage.frame.width, height: 100)) {
            subtitlePage.textColor = gradientColor1
            
        }
        subtitlePage.text  = NSLocalizedString("subtitleQRPage", comment: "Не удалось сохранить заказ")
        subtitlePage.font = UIFont(name: "REM-Black", size: 23)
        subtitlePage.adjustsFontSizeToFitWidth = true
        subtitlePage.minimumScaleFactor = 0.5
        
       
        
       
      
        
    
    }
    

    @IBAction func tappedBack(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
   
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

  
    
    
}

