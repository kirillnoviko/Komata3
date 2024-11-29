import UIKit



class CellMainButtom: UICollectionViewCell {
    
   
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
         
           self.layer.cornerRadius = 13
           self.layer.masksToBounds = true
            changeColorDefault()
       }
    func configure(with text: String) {
           label.text = text
       }
    
    func changeColorDefault() {
        guard let bounds = label.bounds as CGRect? else { return }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: bounds) {
            label.textColor = gradientColor
        }
       }
    
    
   
}
