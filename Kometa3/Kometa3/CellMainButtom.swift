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
        if let gradientColor = GradientTextHelper.gradientColor(bounds: CGRect(x: 0, y: 0, width: 300, height: 100)) {
            label.textColor = gradientColor
            
        }
       }
    
    
   
}
