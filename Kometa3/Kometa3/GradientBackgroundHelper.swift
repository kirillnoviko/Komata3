import UIKit

class GradientBackgroundHelper {

    static func applyGradient(
        to view: UIView,
        startColor: UIColor = UIColor(hex: "#868DFF")!,
        endColor: UIColor = UIColor(hex: "#00E4FF")!,
        cornerRadius: CGFloat = 30,
        padding: CGFloat? = nil
    ) {
        // Создаем градиентный слой
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = true
        if let oldLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldLayer.removeFromSuperlayer()
        }
        
        // Добавляем новый градиентный слой
        view.layer.insertSublayer(gradientLayer, at: 0)
        // Добавляем отступы для UITextField, если указано
        if let textField = view as? UITextField, let paddingValue = padding {
            addPadding(to: textField, padding: paddingValue)
        }
    }
    private static func addPadding(to textField: UITextField, padding: CGFloat) {
        // Левый отступ
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
    }
}

// Добавление UIColor(hex:) для удобства работы с HEX-кодами

