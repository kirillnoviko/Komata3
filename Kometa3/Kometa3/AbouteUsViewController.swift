import UIKit

class AbouteUsViewController: BaseViewControllerMainButton, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let buttons: [(title: String, textView: String)] = [
        (NSLocalizedString("buttonAboutePage1Title", comment: "Заголовок кнопки 1"),
         NSLocalizedString("buttonAboutePage1TextView", comment: "Текст для TextView 1")),
        (NSLocalizedString("buttonAboutePage2Title", comment: "Заголовок кнопки 2"),
         NSLocalizedString("buttonAboutePage2TextView", comment: "Текст для TextView 2")),
        (NSLocalizedString("buttonAboutePage3Title", comment: "Заголовок кнопки 3"),
         NSLocalizedString("buttonAboutePage3TextView", comment: "Текст для TextView 3")),
        (NSLocalizedString("buttonAboutePage4Title", comment: "Заголовок кнопки 4"),
         NSLocalizedString("buttonAboutePage4TextView", comment: "Текст для TextView 4"))
    ]
    
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
        buttonBack.setTitle(NSLocalizedString("buttonBackTitle", comment: "Текст для кнопки назад"), for: .normal )
     
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 23)
        buttonBack.titleLabel?.adjustsFontSizeToFitWidth = true
        
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
       
            return
        }
        
        let button = buttons[indexPath.item]
        
      
        let storyboard = UIStoryboard(name: "AbouteUsDetail", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "AbouteUsDetailViewController") as? AbouteUsDetailViewController else {
           
            return
        }
        controller.titleText = button.title
        controller.viewText = button.textView
        controller.buttonText = NSLocalizedString("buttonBackTitle", comment: "Текст для кнопки назад")

   
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
        return 8
    }
}

