import UIKit
import RealmSwift

class RequestMyNotesViewController: BaseViewControllerMainButton, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonBack: UIButton!
    

    var requests: [Order] = []
    
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
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePage.textColor = gradientColor
        }
        titlePage.text = NSLocalizedString("titlePageRequestMyNotes", comment: "Текст для кнопки назад")
        buttonBack.setTitle(NSLocalizedString("buttonBackTitleStack", comment: "Текст для кнопки назад"), for: .normal)
        buttonBack.layer.cornerRadius = 26
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
       
   

       buttonBack.clipsToBounds = true
      
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        buttonBack.setTitle(NSLocalizedString("buttonBackTitle", comment: "Назад"), for: .normal)
        
      
        collectionView.register(MyRequestCell.self, forCellWithReuseIdentifier: "MyRequestCell")
        
     
        loadRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
 
    
    @IBAction func tappedBack(_ sender: UIButton) {
        ParentNavigationController?.popViewController(animated: true)
    }
    

    private func loadRequests() {
        do {
            let realm = try Realm()
            let results = realm.objects(Order.self)
            self.requests = Array(results)
            collectionView.reloadData()
        } catch {
            print(" Realm: \(error)")
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRequestCell", for: indexPath) as? MyRequestCell else {
            fatalError("Не удалось загрузить ячейку MyRequestCell")
        }
        
        let request = requests[indexPath.item]
        cell.configure(with: request)
   
        cell.deleteButtonAction = { [weak self] in
            self?.confirmDeletion(for: request)
        }
        
        return cell
    }
    
    private func confirmDeletion(for order: Order) {
        let alert = UIAlertController(
            title: NSLocalizedString("confirmDeletionTitle", comment: "Удаление"),
            message: NSLocalizedString("confirmDeletionMessage", comment: "Вы действительно хотите удалить заказ?"),
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancelButton", comment: "Отмена"), style: .cancel))
        alert.addAction(UIAlertAction(title: NSLocalizedString("deleteButton", comment: "Удалить"), style: .destructive, handler: { _ in
            self.deleteOrder(order)
        }))
        
        present(alert, animated: true)
    }
    
    private func deleteOrder(_ order: Order) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(order)
            }
            self.requests.removeAll { $0 == order }
            collectionView.reloadData()
        } catch {
            print("Ошибка удаления из Realm: \(error)")
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 
    }
}
