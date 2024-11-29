import UIKit

class MiniGameViewController: BaseViewControllerMainButton {
 
    
    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var labelTitlePage: UILabel!
    @IBOutlet weak var labelTimeTitle: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    private var cards: [Card] = []
    private var flippedCards: [IndexPath] = []
    private var timer: Timer?
    private var remainingTime = 60

    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
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
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        
        buttonBack.setTitle(NSLocalizedString("buttonBackTitleStack", comment: "Текст для кнопки назад"), for: .normal)
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        
        
        backgroundImage.layer.cornerRadius = 25
   
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            self.labelTitlePage.textColor = gradientColor
        }
        labelTitlePage.text = NSLocalizedString("titleLablePageMinigame", comment: "Заголовок страницы")
        labelTitlePage.font = UIFont(name: "REM-Black", size: 50)
        labelTitlePage.adjustsFontSizeToFitWidth = true
        labelTitlePage.minimumScaleFactor = 0.5
        
        
        
        
        labelTimeTitle.text = NSLocalizedString("subtitleLablePageMinigame", comment: "Заголовок страницы")
        labelTimeTitle.font = UIFont(name: "REM-Black", size: 28)
        labelTimeTitle.adjustsFontSizeToFitWidth = true
        labelTimeTitle.minimumScaleFactor = 0.5
        labelTimeTitle.textColor = .white
        
        timerLabel.text = NSLocalizedString("timerLablePageMinigame", comment: "Заголовок страницы")
        timerLabel.font = UIFont(name: "REM-Black", size: 28)
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.minimumScaleFactor = 0.5
      
        guard let bounds = self.view.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: CGRect(x: 0, y: 0, width: 80, height: 100), startColor: UIColor(hex: "#04607A")!, endColor: UIColor(hex: "#46237F")! ) {
            timerLabel.textColor = gradientColor
        }
      
        setupGame()
        startTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        navigationController?.setNavigationBarHidden(true, animated: true)
        resetGame()
    }
    private func resetGame() {
        flippedCards.removeAll()
        cards.removeAll()
        remainingTime = 60
        timer?.invalidate()
        timer = nil
        setupGame()
        startTimer()
        collectionView.reloadData()
    }
    
    private func setupGame() {
       
        let images = ["cellGame1", "cellGame2", "cellGame3", "cellGame4", "star", "cellGame5"]
        var deck = images.flatMap { [Card(id: UUID().hashValue, imageName: $0), Card(id: UUID().hashValue, imageName: $0)] }
        deck.shuffle()
        
        cards = deck
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func startTimer() {
        timerLabel.text = "0: \(remainingTime)"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.remainingTime -= 1
            self.timerLabel.text = "0: \(self.remainingTime)"
            
            if self.remainingTime == 0 {
                self.timer?.invalidate()
                self.showGameOverScreen(isWin: false)
            }
        }
    }
    
    private func showGameOverScreen(isWin: Bool) {
        let storyboardString = isWin ? "WinPages" : "LosePages"
        let storyboard = UIStoryboard(name: storyboardString, bundle: nil)
        let viewControllerID = isWin ? "WinPages" : "LosePages"
        
 
        guard let gameOverVC = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? BaseViewControllerMainButton else {
            print("Ошибка: Не удалось загрузить контроллер с ID \(viewControllerID)")
            return
        }
        gameOverVC.ParentNavigationController = navigationController
        
        navigationController?.pushViewController(gameOverVC, animated: true)

    }
    
    @IBAction func tappedBack(_ sender: Any) {
        ParentNavigationController?.popViewController(animated: true)
    }
    private func checkForMatch() {
        guard flippedCards.count == 2 else { return }
        
        let firstIndex = flippedCards[0]
        let secondIndex = flippedCards[1]
        
        let firstCard = cards[firstIndex.item]
        let secondCard = cards[secondIndex.item]
        
        if firstCard.imageName == secondCard.imageName {
            cards[firstIndex.item].isMatched = true
            cards[secondIndex.item].isMatched = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.cards[firstIndex.item].isFlipped = false
                self.cards[secondIndex.item].isFlipped = false
                self.collectionView.reloadItems(at: [firstIndex, secondIndex])
            }
        }
        
        flippedCards.removeAll()
        
        
        if cards.allSatisfy({ $0.isMatched }) {
            timer?.invalidate()
            showGameOverScreen(isWin: true)
        }
    }
}
extension MiniGameViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        let card = cards[indexPath.item]
        
        if card.isFlipped || card.isMatched {
            cell.configure(with: card.imageName)
        } else {
            cell.configure(with: "cellGameBackground")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard flippedCards.count < 2 else { return }
        
        var card = cards[indexPath.item]
        guard !card.isFlipped && !card.isMatched else { return }
        
        card.isFlipped = true
        cards[indexPath.item] = card
        flippedCards.append(indexPath)
        collectionView.reloadItems(at: [indexPath])
        
        if flippedCards.count == 2 {
            checkForMatch()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.bounds.width - (padding * 4)
        let width = availableWidth / 3
        return CGSize(width: width, height: width) 
    }
}

