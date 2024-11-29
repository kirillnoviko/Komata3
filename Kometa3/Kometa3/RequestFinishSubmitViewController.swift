import UIKit

class RequestFinishSubmitViewController: BaseViewControllerMainButton {
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var buttonBack: UIButton!

    @IBOutlet weak var labelTextSucces: UILabel!
    
 
    
    
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
     
        buttonBack.setTitle(NSLocalizedString("buttonBackTitle", comment: "Текст для кнопки назад"), for: .normal )
        labelTextSucces.text = NSLocalizedString("textFinishPage", comment: "Текст для кнопки назад")
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        
 
    }
    @IBAction func tappedBack(_ sender: Any) {
    
         if let navigationController = ParentNavigationController {
             navigationController.popToRootViewController(animated: true)
         } else {
             print("Ошибка: ParentNavigationController отсутствует")
         }
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        


        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

   
    

    
   
}

