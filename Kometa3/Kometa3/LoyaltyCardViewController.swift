
import UIKit

class LoyaltyCardViewController: BaseViewControllerMainButton, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var viewForStackLabel: UIView!
    @IBOutlet weak var labelprice: UILabel!
    @IBOutlet weak var labelBase: UILabel!
    @IBOutlet weak var labelLwevel: UILabel!
    @IBOutlet weak var labelDiscountprocent: UILabel!
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var labelCashbackprocent: UILabel!
    @IBOutlet weak var labelCashback: UILabel!
    @IBOutlet weak var labelMyBonus: UILabel!
    @IBOutlet weak var titlePage: UILabel!
    let buttons: [(title: String,  storyboardID: String)] = [
        (NSLocalizedString("GalleryButton", comment: "Заголовок кнопки 1"),
         NSLocalizedString("QRCodePagetStoryboard", comment: "storyboard")),

        (NSLocalizedString("QRCodeTitleButton", comment: "Заголовок кнопки 2"),
        NSLocalizedString("GalleryPageStoryboard", comment: "storyboard2")),
         
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            t.constant = 70
            r.constant = -170
            b.constant = -70
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
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 25)

        setupLabel(titlePage, text: NSLocalizedString("titleCardPage", comment: "Не удалось сохранить заказ"),  check: 1 )
        setupLabel(labelCashbackprocent, text: NSLocalizedString("cashbackprocentCardPage", comment: "Не удалось сохранить заказ"), check: 1 )
        setupLabel(labelDiscountprocent, text: NSLocalizedString("discountprocentCardPage", comment: "Не удалось сохранить заказ"), check: 1 )
        setupLabel(labelMyBonus, text: NSLocalizedString("myBonusCardPage", comment: "Не удалось сохранить заказ"), check: 1 )
        setupLabel(labelLwevel, text: NSLocalizedString("levelCardPage", comment: "Не удалось сохранить заказ"), check: 1 )
        setupLabel(labelprice, text: NSLocalizedString("priceCardPage", comment: "Не удалось сохранить заказ"), check: 1 )
        setupLabel(labelBase, text: NSLocalizedString("baseCardPage", comment: "Не удалось сохранить заказ"))
        setupLabel(labelCashback, text: NSLocalizedString("cashbackCardPage", comment: "Не удалось сохранить заказ"))
        setupLabel(labelDiscount, text: NSLocalizedString("discountCardPage", comment: "Не удалось сохранить заказ"))
        
        titlePage.font = UIFont(name: "REM-Black", size: 23)
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePage.textColor = gradientColor
        }
        labelMyBonus.font = UIFont(name: "REM-Black", size: 28)
        labelLwevel.font = UIFont(name: "REM-Black", size: 24)
        labelBase.font = UIFont(name: "REM-Black", size: 18)
        labelCashback.font = UIFont(name: "REM-Black", size: 16)
        labelDiscount.font = UIFont(name: "REM-Black", size: 16)
        labelprice.font = UIFont(name: "REM-Black", size: 23)
        labelCashbackprocent.font = UIFont(name: "REM-Black", size: 23)
        labelDiscountprocent.font = UIFont(name: "REM-Black", size: 23)
        
        viewForStackLabel.layer.cornerRadius = 30
        viewForStackLabel.clipsToBounds = true //
        let nib = UINib(nibName: "CellMainButton", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CellMainButtom")
    }
    
    

    
    
    private func setupLabel(_ label: UILabel, text: String? = nil, check: Int? = 0) {
        if check == 1{
            guard let bounds = self.view.bounds as CGRect? else { return }
            if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
                label.textColor = gradientColor
            }
        }else{
            label.textColor = .white
        }
       
        label.font = UIFont(name: "REM-Black", size: 18)
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
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
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2 - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 
    }
}

