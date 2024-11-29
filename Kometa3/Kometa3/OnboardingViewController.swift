import UIKit



class OnboardingViewController:  BaseViewControllerMainButton {
  
    @IBOutlet weak var titlePrivacy: UILabel!
    
    @IBOutlet weak var buttonAllow: UIButton!
    @IBOutlet weak var textViewPrivacy: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlePrivacy.text = NSLocalizedString("labelTitlePagePrivacy", comment: "Текст для кнопки назад")
        setup()

    }
    override func viewWillAppear(_ animated: Bool) {
     

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

   
    private func setup() {
        buttonAllow.layer.cornerRadius = 33
        buttonAllow.clipsToBounds = true //
        buttonAllow.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        if OnboardingManager.isOnboardingCompleted() {
                buttonAllow.setTitle(NSLocalizedString("buttonBackTitle", comment: "Текст для кнопки назад"), for: .normal)
           
            } else {
                buttonAllow.setTitle(NSLocalizedString("buttonAllowPrivacy", comment: "Текст для кнопки назад"), for: .normal)
               
            }
        textViewPrivacy.translatesAutoresizingMaskIntoConstraints = false
        
     
        textViewPrivacy.layer.cornerRadius = 25
        textViewPrivacy.layer.masksToBounds = true
        textViewPrivacy.isEditable = false
        textViewPrivacy.isSelectable = false
     
          if let gradientColor = GradientTextHelper.gradientColor(bounds: CGRect(x: 0, y: 0, width: 400, height: 100)) {
              titlePrivacy.textColor = gradientColor
              
          }
        
    }
    
   
    
    


    @IBAction func tappedAllowPrivacy(_ sender: Any) {
        if OnboardingManager.isOnboardingCompleted() {
            ParentNavigationController?.popViewController(animated: true)
           
            } else {
                OnboardingManager.setOnboardingCompleted()
                   
              
                   guard let ParentNavigationController = ParentNavigationController else { return }
                   let storyboard = UIStoryboard(name: "MainWindow", bundle: nil)
                   if let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                       ParentNavigationController.setViewControllers([mainVC], animated: true)
                   }
               
            }
       
    }
  
 
       
        
}

    



    


    



