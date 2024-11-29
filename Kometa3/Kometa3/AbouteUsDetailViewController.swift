import UIKit



class AbouteUsDetailViewController: UIViewController {
    weak var ParentNavigationController: UINavigationController?
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!

    
    @IBOutlet weak var titlePage: UILabel!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var textViewPage: UITextView!
    
    var titleText: String?
    var viewText: String?
    var buttonText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            r.constant = -200
            b.constant = -150
           
        }else{
           
            r.constant = 0
            b.constant = 0
           

        }
    }
    private func setup() {
        
        titlePage.text = titleText
        textViewPage.text = viewText
        buttonBack.setTitle(NSLocalizedString("buttonBackTitle", comment: "Текст для кнопки назад"), for: .normal )
        buttonBack.setTitle(buttonText, for: .normal)
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 23)
        buttonBack.titleLabel?.adjustsFontSizeToFitWidth = true
        
        textViewPage.translatesAutoresizingMaskIntoConstraints = false
        
        
        textViewPage.layer.cornerRadius = 25
        textViewPage.layer.masksToBounds = true
        textViewPage.isEditable = false
        textViewPage.isSelectable = false
       
         guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePage.textColor = gradientColor
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
 

     
 

    
    


    @IBAction func tappedAllowPrivacy(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
    }
  
 
       
        
}

    



    


    



