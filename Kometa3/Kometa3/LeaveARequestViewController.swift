import UIKit

class LeaveARequestViewController: BaseViewControllerMainButton, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let buttons: [(title: String,  storyboardID: String)] = [
        (NSLocalizedString("leaveARequestButton", comment: "Заголовок кнопки 1"),
         NSLocalizedString("leaveARequestStoryboard", comment: "storyboard")),
        
        (NSLocalizedString("myRequestButton", comment: "Заголовок кнопки 2"),
        NSLocalizedString("myRequestStoryboard", comment: "storyboard2")),
         
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
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        
        let nib = UINib(nibName: "CellMainButton", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CellMainButtom")
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
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 
    }
}

