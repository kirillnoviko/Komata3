import UIKit
import RealmSwift

// Модель для сохранения отзыва
class Feedback: Object {
    @Persisted var name: String = ""
    @Persisted var feedbackText: String = ""
    @Persisted var rating: Int = 0
    @Persisted var createdAt: Date = Date()
}

class SettingsReviewsLeaveViewController: BaseViewControllerMainButton, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    @IBOutlet weak var labelFeedbackTextView: UILabel!
    @IBOutlet weak var labelNameTextfield: UILabel!
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    
    private var selectedRating: Int = 0 
    
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
          configureUI()
        
        nameTextField.delegate = self
        feedbackTextView.delegate = self
        
          
    
          setupTapGesture()
        // Добавляем предустановленные отзывы, если это первый запуск
       
       
    }


    

      @objc private func dismissKeyboard() {
          view.endEditing(true)
      }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        tapGesture.cancelsTouchesInView = false // Позволяет другим элементам обрабатывать события тапа
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func handleTapOutside(_ sender: UITapGestureRecognizer) {
        view.endEditing(true) // Скрыть клавиатуру
    }
    private func configureUI() {
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePage.textColor = gradientColor
        }
        
        titlePage.text = NSLocalizedString("titlePageReviewsLeave", comment: "Placeholder для имени")
        titlePage.font = UIFont(name: "REM-Black", size: 30)
        nameTextField.layer.cornerRadius = 30
        nameTextField.clipsToBounds = true //
        
        labelFeedbackTextView.font = UIFont(name: "REM-Black", size: 24)
        labelNameTextfield.font = UIFont(name: "REM-Black", size: 24)
        labelFeedbackTextView.text = NSLocalizedString("labelFeedbackTextViewPageReviewsLeave", comment: "Placeholder для имени")
        labelNameTextfield.text = NSLocalizedString("labelNameTextfieldPageReviewsLeave", comment: "Placeholder для имени")
        
     
        
   
        nameTextField.layer.cornerRadius = 25
        nameTextField.font = UIFont(name: "REM-Black", size: 20)
        nameTextField.textColor = .white

    
        feedbackTextView.setBackground(imageName: "background_button", cornerRadius: 26)
        
        buttonBack.setTitle(NSLocalizedString("buttonBackTitleStack", comment: "Текст для кнопки назад"), for: .normal)
        buttonBack.layer.cornerRadius = 28
        buttonBack.clipsToBounds = true //
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping // Разрешаем перенос слов
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 26)

        
        buttonSend.layer.cornerRadius = 28
        buttonSend.clipsToBounds = true //
        buttonSend.setTitle(NSLocalizedString("sendButtun", comment: "Кнопка отправки"), for: .normal)
        buttonSend.titleLabel?.font = UIFont(name: "REM-Black", size: 26)
        
        configureStarButtons()
    }
    
    private func configureStarButtons() {
        let starButtons = [star1Button, star2Button, star3Button, star4Button, star5Button]
        for (index, button) in starButtons.enumerated() {
            button?.tag = index + 1
            button?.setImage(UIImage(named: "star"), for: .normal)
            button?.setImage(UIImage(named: "starSelect"), for: .selected)
            button?.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        selectedRating = sender.tag
        updateStarButtons()
    }
    
    private func updateStarButtons() {
        let starButtons = [star1Button, star2Button, star3Button, star4Button, star5Button]
        for button in starButtons {
            button?.isSelected = button?.tag ?? 0 <= selectedRating

        }
    }
    
    @IBAction func submitFeedback(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: NSLocalizedString("errorTitle", comment: "Кнопка отправки"), message: NSLocalizedString("errorInsertTitle", comment: "Кнопка отправки"))
            return
        }
        
        guard let feedback = feedbackTextView.text, !feedback.isEmpty else {
            showAlert(title: NSLocalizedString("errorTitle", comment: "Кнопка отправки"), message: NSLocalizedString("errorInsertTitle", comment: "Кнопка отправки"))
            return
        }
        
        guard selectedRating > 0 else {
            showAlert(title: NSLocalizedString("errorTitle", comment: "Кнопка отправки"), message: NSLocalizedString("errorInsertTitle", comment: "Кнопка отправки"))
            return
        }
        
        let newFeedback = Feedback()
        newFeedback.name = name
        newFeedback.feedbackText = feedback
        newFeedback.rating = selectedRating
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newFeedback)
            }
            showSuccessAlert()
        } catch {
            
            
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showSuccessAlert() {
        let successAlert = UIAlertController(
            title: NSLocalizedString("Thanks", comment: "Успех"),
            message: NSLocalizedString("feedbacksuccessfully", comment: "Сообщение об успехе"),
            preferredStyle: .alert
        )
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.clearForm()
            self.ParentNavigationController?.popViewController(animated: true)
        }))
        present(successAlert, animated: true)
    }
    
    private func clearForm() {
        nameTextField.text = ""
        feedbackTextView.text = ""
        selectedRating = 0
        updateStarButtons()
    }
    
    @IBAction func tappedBack(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
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


extension UITextView {
   
    func setBackground(imageName: String, cornerRadius: CGFloat) {
        
        if let backgroundImage = UIImage(named: imageName) {
            let imageView = UIImageView(frame: self.bounds)
            imageView.image = backgroundImage
            imageView.contentMode = .scaleToFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = cornerRadius
            imageView.layer.masksToBounds = true
            self.addSubview(imageView)
            self.sendSubviewToBack(imageView)
        }
        
     
        self.font = UIFont(name: "REM-Black", size: 20)
        self.textColor = .white
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}

