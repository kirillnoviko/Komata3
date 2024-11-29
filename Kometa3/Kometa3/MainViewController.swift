import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var constraint1: NSLayoutConstraint!
    
    @IBOutlet weak var constraint2: NSLayoutConstraint!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let buttons: [(text: String, storyboardID: String)] = [
        (NSLocalizedString("button1", comment: "Кнопка 1") ,"AbouteUs"),
        (NSLocalizedString("button2", comment: "Кнопка 2"), "LeaveARequest"),
        (NSLocalizedString("button3", comment: "Кнопка 3"), "LoyaltyCard"),
        (NSLocalizedString("button4", comment: "Кнопка 4"), "Settings"),
        (NSLocalizedString("button5", comment: "Кнопка 5"), "MiniGame")
    ]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            constraint1.constant = -200
            constraint2.constant = -200
        }else{
            constraint1.constant = 0
            constraint2.constant = 0
        }
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "CellMainButton", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CellMainButtom")
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
        

        let storyboard = UIStoryboard(name: button.storyboardID, bundle: nil) // Убедитесь, что имя Storyboard верное
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
               cell.configure(with: buttonData.text)
               return cell
           }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 
    }
}
