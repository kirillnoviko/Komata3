import UIKit

class MyRequestCell: UICollectionViewCell {
    
    // Элементы UI
    private let serviceTitleLabel = UILabel()
    private let serviceNameLabel = UILabel()
    private let customerDataLabel = UILabel() // Новый UILabel для подписи "Данные для заказчика:"
    private let customerInfoLabel = UILabel()
    private let dateTimeLabel = UILabel()
    private let deleteButton = UIButton(type: .system)
    
    var deleteButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        applyGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        applyGradientBackground()
    }
    
    private func setupViews() {
        // Настройка подписей
        setupLabel(serviceTitleLabel, text: NSLocalizedString("labelForCellService", comment: "Текст для кнопки назад"))
        setupLabel(customerDataLabel, text: NSLocalizedString("labelForCellDate", comment: "Текст для кнопки назад"))
        
        // Настройка значений
        setupLabel(serviceNameLabel)
        serviceNameLabel.numberOfLines = 2
        
        setupLabel(customerInfoLabel)
        setupLabel(dateTimeLabel)
        
        // Настройка кнопки удаления
        deleteButton.setTitle("✕", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "REM-Black", size: 20)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        // Добавление элементов в ячейку
        contentView.addSubview(serviceTitleLabel)
        contentView.addSubview(serviceNameLabel)
        contentView.addSubview(customerDataLabel)
        contentView.addSubview(customerInfoLabel)
        contentView.addSubview(dateTimeLabel)
        contentView.addSubview(deleteButton)
        
        // Настройка Auto Layout
        serviceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        customerDataLabel.translatesAutoresizingMaskIntoConstraints = false
        customerInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Первая строка: подпись и название услуги
            serviceTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            serviceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            serviceTitleLabel.widthAnchor.constraint(equalToConstant: 80),
            
            serviceNameLabel.topAnchor.constraint(equalTo: serviceTitleLabel.topAnchor),
            serviceNameLabel.leadingAnchor.constraint(equalTo: serviceTitleLabel.trailingAnchor, constant: 8),
            serviceNameLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            
            // Вторая строка: подпись для данных заказчика
            customerDataLabel.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 8),
            customerDataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customerDataLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            
            // Имя и телефон на одной строке
            customerInfoLabel.topAnchor.constraint(equalTo: customerDataLabel.bottomAnchor, constant: 4),
            customerInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customerInfoLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            
            // Третья строка: дата и время
            dateTimeLabel.topAnchor.constraint(equalTo: customerInfoLabel.bottomAnchor, constant: 8),
            dateTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateTimeLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            
            // Кнопка удаления
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // Настройка внешнего вида ячейки
        contentView.layer.cornerRadius = 30 // Скругление углов
        contentView.clipsToBounds = true
    }
    
    // Настройка общих параметров для UILabel
    private func setupLabel(_ label: UILabel, text: String? = nil) {
        label.font = UIFont(name: "REM-Black", size: 14)
        label.textColor = .white
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
    }
    
    // Применение градиентного фона
    private func applyGradientBackground() {
        GradientBackgroundHelper.applyGradient(
            to: contentView,
            startColor: UIColor(hex: "#868DFF")!,
            endColor: UIColor(hex: "#00E4FF")!,
            cornerRadius: 30
        )
    }
    
    // Метод для настройки данных
    func configure(with order: Order) {
        serviceNameLabel.text = order.serviceName
        customerInfoLabel.text = "\(order.customerName) \(order.phoneNumber)"
        dateTimeLabel.text = order.dateTime
    }
    
    @objc private func deleteButtonTapped() {
        deleteButtonAction?()
    }
}
