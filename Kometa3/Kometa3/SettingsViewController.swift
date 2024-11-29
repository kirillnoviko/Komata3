import UIKit
import RealmSwift

class SettingsViewController: BaseViewControllerMainButton, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let buttons: [(title: String,  storyboardID: String)] = [
        (NSLocalizedString("reviewsSettingsButton", comment: "Заголовок кнопки 1"),
         NSLocalizedString("reviewsSettingsStoryboard", comment: "storyboard")),
        
        (NSLocalizedString("leaveReviewsSettingsButton", comment: "Заголовок кнопки 2"),
        NSLocalizedString("leaveReviewsSettingsStoryboard", comment: "storyboard2")),
        
        (NSLocalizedString("settingsButton", comment: "Заголовок кнопки 1"),
         NSLocalizedString("settingsStoryboard", comment: "storyboard")),
        
        (NSLocalizedString("privacySettingsButton", comment: "Заголовок кнопки 2"),
        NSLocalizedString("privacySettingsStoryboard", comment: "storyboard2")),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            t.constant = 70
            r.constant = -170
            b.constant = 70
            l.constant = 170
        }else{
            t.constant = 0
            r.constant = 0
            b.constant = 0
            l.constant = 0

        }
        collectionView.dataSource = self
        collectionView.delegate = self
        buttonBack.setTitle(NSLocalizedString("buttonBackTitle", comment: "Текст для кнопки назад"), for: .normal )
        buttonBack.clipsToBounds = true
        buttonBack.layer.cornerRadius = 29
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 28)
        
        let nib = UINib(nibName: "CellMainButton", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CellMainButtom")
        
        addDefaultFeedbacksIfNeeded()
    }
    private func addDefaultFeedbacksIfNeeded() {
        let hasAddedFeedbacksKey = "hasAddedDefaultFeedbacks"
        let defaults = UserDefaults.standard
        
        if !defaults.bool(forKey: hasAddedFeedbacksKey) {
            let defaultFeedbacks = [
                Feedback(value: [
                    "name": "Иван Жизневский",
                    "feedbackText": "Отличный сервис! Очень доволен работой.",
                    "rating": 5,
                    "createdAt": Date()
                ]),
                Feedback(value: [
                    "name": "Мария Колесникова",
                    "feedbackText": "Хорошая поддержка и быстрое обслуживание.",
                    "rating": 4,
                    "createdAt": Date()
                ]),
                Feedback(value: [
                    "name": "Алексей Сидоров",
                    "feedbackText": "Работа выполнена качественно, но пришлось ждать.",
                    "rating": 3,
                    "createdAt": Date()
                ]),
                Feedback(value: [
                    "name": "Елена Смирнова",
                    "feedbackText": "Все супер, спасибо большое!",
                    "rating": 5,
                    "createdAt": Date()
                ])
            ]
            
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(defaultFeedbacks)
                }
                print("Предустановленные отзывы добавлены.")
                
                // Помечаем, что отзывы были добавлены
                defaults.set(true, forKey: hasAddedFeedbacksKey)
            } catch {
                print("Ошибка добавления предустановленных отзывов: \(error)")
            }
        }
    }
    @IBAction func tappedBack(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
     
        collectionView.dataSource = self
        collectionView.delegate = self
        

        collectionView.reloadData()
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < buttons.count else {
            print("Контроллер для данного индекса не найден.")
            return
        }
        
        let button = buttons[indexPath.item]
        
    
        let storyboard = UIStoryboard(name: button.storyboardID, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: button.storyboardID) as? BaseViewControllerMainButton else {
            print("Ошибка: Не удалось загрузить контроллер с ID \(button.storyboardID)")
            return
        }
        
        
      
        controller.ParentNavigationController = navigationController
        
     
        navigationController?.pushViewController(controller, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMainButtom", for: indexPath) as! CellMainButtom
        let buttonData = buttons[indexPath.item]
        cell.configure(with: buttonData.title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/4 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 // Вертикальный отступ между ячейками
    }
}

