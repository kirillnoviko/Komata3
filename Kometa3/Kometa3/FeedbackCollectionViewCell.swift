import UIKit

class FeedbackCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeedbackCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "REM-Black", size: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 2 // Расстояние между звёздами
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let feedbackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "REM-Light", size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    private func configureCell() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.25) // Прозрачность 25%

        contentView.addSubview(nameLabel)
        contentView.addSubview(starsStackView)
        contentView.addSubview(feedbackLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            starsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            starsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            feedbackLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 4),
            feedbackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            feedbackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            feedbackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    func configure(with feedback: Feedback) {
        nameLabel.text = feedback.name
        feedbackLabel.text = feedback.feedbackText
        
        // Удаляем старые звёздочки
        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Добавляем количество звёзд, соответствующее рейтингу
        for _ in 1...feedback.rating {
            let starImage = UIImageView()
            starImage.image = UIImage(named: "star") // Выбранная звезда
            starImage.contentMode = .scaleAspectFit
            starImage.widthAnchor.constraint(equalToConstant: 18).isActive = true
            starImage.heightAnchor.constraint(equalToConstant: 18).isActive = true
            starsStackView.addArrangedSubview(starImage)
        }
    }
}
