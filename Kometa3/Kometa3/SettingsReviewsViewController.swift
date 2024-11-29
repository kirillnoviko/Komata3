import UIKit
import RealmSwift

class  SettingsReviewsViewController: BaseViewControllerMainButton, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    @IBOutlet weak var buttonLeaveReviews: UIButton!
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
   @IBOutlet weak var collectionView: UICollectionView!
    
    private var feedbacks: [Feedback] = []

    
    
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

        buttonBack.setTitle(NSLocalizedString("buttonBackTitleStack", comment: "Текст для кнопки назад"), for: .normal )
        buttonLeaveReviews.setTitle(NSLocalizedString("buttonLeaveReviewsNextPage", comment: "Текст для кнопки назад"), for: .normal )
        
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping // Разрешаем перенос слов
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        if let gradientColor = GradientTextHelper.gradientColor(bounds: CGRect(x: 0, y: 0, width: titlePage.frame.width, height: 100)) {
            titlePage.textColor = gradientColor
            
        }
        titlePage.text  = NSLocalizedString("titleSettingsReviewsPage", comment: "Не удалось сохранить заказ")
        titlePage.font = UIFont(name: "REM-Black", size: 43)
        titlePage.adjustsFontSizeToFitWidth = true
        titlePage.minimumScaleFactor = 0.5

        collectionView.delegate = self
       collectionView.dataSource = self
       collectionView.register(FeedbackCollectionViewCell.self, forCellWithReuseIdentifier: FeedbackCollectionViewCell.identifier)
       loadFeedbacks()
    }
    private func loadFeedbacks() {
        do {
            let realm = try Realm()
            feedbacks = Array(realm.objects(Feedback.self).sorted(byKeyPath: "createdAt", ascending: false))
            collectionView.reloadData()
        } catch {
            print("Ошибка загрузки отзывов: \(error)")
        }
    }
    @IBAction func tappedLeaveReviews(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SettingsReviewsLeave", bundle: nil) // Убедитесь, что имя Storyboard верное
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SettingsReviewsLeave") as? BaseViewControllerMainButton else {
          
            return
        }
        
        
        controller.ParentNavigationController = navigationController
        
       
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func tappedBack(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        buttonBack.clipsToBounds = true
        buttonBack.layer.cornerRadius = 29
        buttonLeaveReviews.clipsToBounds = true
        buttonLeaveReviews.layer.cornerRadius = 29
      
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 18)
        buttonLeaveReviews.titleLabel?.font = UIFont(name: "REM-Black", size: 23)

        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

  
    
    // MARK: UICollectionViewDataSource
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return feedbacks.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedbackCollectionViewCell.identifier, for: indexPath) as? FeedbackCollectionViewCell else {
              return UICollectionViewCell()
          }
          cell.configure(with: feedbacks[indexPath.item])
          return cell
      }
      
  
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.frame.width, height: 80)
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 16
      }
}

