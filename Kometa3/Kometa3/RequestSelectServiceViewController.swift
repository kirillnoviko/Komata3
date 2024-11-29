import UIKit

class RequestSelectServiceViewController: BaseViewControllerMainButton, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let buttons: [(String)] = [
        NSLocalizedString("buttonSelectServicePageTitle1", comment: "Заголовок кнопки 1"),
        NSLocalizedString("buttonSelectServicePageTitle2", comment: "Заголовок кнопки 1"),
        NSLocalizedString("buttonSelectServicePageTitle3", comment: "Заголовок кнопки 1"),
        NSLocalizedString("buttonSelectServicePageTitle4", comment: "Заголовок кнопки 1"),
        NSLocalizedString("buttonSelectServicePageTitle5", comment: "Заголовок кнопки 1"),
        NSLocalizedString("buttonSelectServicePageTitle6", comment: "Заголовок кнопки 1"),

      
    ]
    
    var selectedService: String?
    
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
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.titlePage.textColor = gradientColor
        }

        collectionView.dataSource = self
        collectionView.delegate = self
        titlePage.text = NSLocalizedString("titlePageSelectService", comment: "Текст для кнопки назад")
        buttonBack.setTitle(NSLocalizedString("buttonBack", comment: "Текст для кнопки назад"), for: .normal)
       buttonNext.setTitle(NSLocalizedString("buttonNext", comment: "Текст для кнопки вперед"), for: .normal)
 
       GradientButtonHelper.applyGradient(to: buttonBack)
       GradientButtonHelper.applyGradient(to: buttonNext)
 
       buttonBack.clipsToBounds = true
       buttonNext.clipsToBounds = true
        
        let nib = UINib(nibName: "CellMainButton", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CellMainButtom")
    }
    @IBAction func tappedBack(_ sender: Any) {
          ParentNavigationController?.popViewController(animated: true)
      }
      
    @IBAction func tappedNext(_ sender: Any) {
        guard let selectedService = selectedService else {
            let alert = UIAlertController(
                title: NSLocalizedString("errorTitle", comment: "Заголовок ошибки"),
                message: NSLocalizedString("errorSelectService", comment: "Сообщение ошибки"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: NSLocalizedString("okButton", comment: "Кнопка ОК"), style: .default))
            present(alert, animated: true)
            return
        }
        
        let storyboard = UIStoryboard(name: "RequestSubmit", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "RequestSubmitViewController") as? RequestSubmitViewController else {
            print("Ошибка: Не удалось загрузить RequestSubmitViewController")
            return
        }
        
        controller.selectedService = selectedService
        controller.ParentNavigationController = navigationController
        
        navigationController?.pushViewController(controller, animated: true)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Убедимся, что делегаты установлены
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Перезагружаем данные
        collectionView.reloadData()
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < buttons.count else { return }
        
        selectedService = buttons[indexPath.item]
        print("Выбрана услуга: \(selectedService ?? "")")
        
  
        collectionView.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMainButtom", for: indexPath) as! CellMainButtom
        let buttonData = buttons[indexPath.item]
        
     
        cell.configure(with: buttonData)
        
   
        if buttons[indexPath.item] == selectedService {
            cell.label.textColor = UIColor.white
        } else {
            cell.changeColorDefault()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 
    }
}

