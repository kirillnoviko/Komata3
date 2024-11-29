import UIKit

class GradientTextHelper {
    /// Создает цвет текста с градиентом
    /// - Parameters:
    ///   - bounds: Размеры, которые будут использованы для создания градиента.
    ///   - startColor: Начальный цвет градиента.
    ///   - endColor: Конечный цвет градиента.
    /// - Returns: Градиентный цвет для текста.
    static func gradientColor(bounds: CGRect, startColor: UIColor = UIColor(hex: "#868DFF")!, endColor: UIColor = UIColor(hex: "#00E4FF")!) -> UIColor? {
        // Создаем слой градиента
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5) // Угол 90 градусов (горизонтальный градиент)
        
        // Рендерим градиент в изображение
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        defer { UIGraphicsEndImageContext() }
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        return UIColor(patternImage: image)
    }
}

extension UIColor {
    /// Инициализация UIColor из HEX-кода
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
