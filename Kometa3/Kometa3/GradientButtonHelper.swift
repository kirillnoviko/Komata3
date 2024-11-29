import UIKit

class GradientButtonHelper {
    static func applyGradient(to button: UIButton, startColor: UIColor = UIColor(hex: "#868DFF")!, endColor: UIColor = UIColor(hex: "#00E4FF")!) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 31 // Закругляем границы слоя
        gradientLayer.masksToBounds = true
        
        // Удаляем старые слои, если есть
        if let oldLayer = button.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldLayer.removeFromSuperlayer()
        }
        
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
}
