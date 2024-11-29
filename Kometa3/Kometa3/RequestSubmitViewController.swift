import UIKit
import RealmSwift

class RequestSubmitViewController: BaseViewControllerMainButton , UITextFieldDelegate{
    
    var selectedService: String?

    @IBOutlet weak var r: NSLayoutConstraint!
    @IBOutlet weak var b: NSLayoutConstraint!
    @IBOutlet weak var t: NSLayoutConstraint!
    @IBOutlet weak var l: NSLayoutConstraint!
    
    
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var textfieldYourName: UITextField!
    @IBOutlet weak var textfieldCarBrand: UITextField!
    @IBOutlet weak var textfieldNumber: UITextField!
    @IBOutlet weak var buttonSelectDateTime: UIButton!
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var labelCarBrand: UILabel!
    @IBOutlet weak var labelnNumber: UILabel!
    @IBOutlet weak var labelYourName: UILabel!

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    var selectedDate: Date?
    var selectedTime: Date?
    var currentDatePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            t.constant = 70
            r.constant = 200
            b.constant = -170
            l.constant = 200
        }else{
            t.constant = 0
            r.constant = 0
            b.constant = 0
            l.constant = 0

        }
        if let gradientColor = GradientTextHelper.gradientColor(bounds: CGRect(x: 0, y: 0, width: 400, height: 100)) {
            titlePage.textColor = gradientColor
          
        }
        labelnNumber.textColor = .white
        labelCarBrand.textColor = .white
        labelYourName.textColor = .white
        labelDateTime.textColor = .white
        buttonSelectDateTime.setTitle(NSLocalizedString("buttonSelect", comment: "Выберите дату и время"), for: .normal)
        buttonBack.setTitle(NSLocalizedString("buttonBack", comment: "button back"), for: .normal)
        buttonNext.setTitle(NSLocalizedString("buttonNext", comment: "button next"), for: .normal)
        titlePage.text = NSLocalizedString("titlePageSubmit", comment: "Выберите дату и время")
        

        textfieldYourName.layer.cornerRadius = 25
        textfieldYourName.clipsToBounds = true
        textfieldCarBrand.layer.cornerRadius = 25
        textfieldCarBrand.clipsToBounds = true
        textfieldNumber.layer.cornerRadius = 25
        textfieldNumber.clipsToBounds = true
        
 
        buttonSelectDateTime.layer.cornerRadius = 33
        buttonSelectDateTime.clipsToBounds = true
        buttonSelectDateTime.titleLabel?.lineBreakMode = .byWordWrapping
        buttonSelectDateTime.titleLabel?.numberOfLines = 0
        buttonSelectDateTime.titleLabel?.textAlignment = .center
        buttonSelectDateTime.titleLabel?.font = UIFont(name: "REM-Black", size: 23)
        
        buttonBack.layer.cornerRadius = 33
        buttonBack.clipsToBounds = true
        buttonBack.titleLabel?.lineBreakMode = .byWordWrapping
        buttonBack.titleLabel?.numberOfLines = 0
        buttonBack.titleLabel?.textAlignment = .center
        buttonBack.titleLabel?.font = UIFont(name: "REM-Black", size: 23)
        
        buttonNext.layer.cornerRadius = 33
        buttonNext.clipsToBounds = true
        buttonNext.titleLabel?.lineBreakMode = .byWordWrapping
        buttonNext.titleLabel?.numberOfLines = 0
        buttonNext.titleLabel?.textAlignment = .center
        buttonNext.titleLabel?.font = UIFont(name: "REM-Black", size: 23)
        

        buttonSelectDateTime.addTarget(self, action: #selector(openCalendarView), for: .touchUpInside)

        
        labelnNumber.text = NSLocalizedString("labelNumberSubmitPage", comment: "text number for number submit page")
        labelDateTime.text = NSLocalizedString("labelDateTimeSubmitPage", comment: "text number for number submit page")
        labelCarBrand.text = NSLocalizedString("labelCarBrandSubmitPage", comment: "text number for number submit page")
        labelYourName.text = NSLocalizedString("labelYourNameSubmitPage", comment: "text number for number submit page")
        textfieldYourName.delegate = self
          textfieldCarBrand.delegate = self
          textfieldNumber.delegate = self
          
        
          textfieldNumber.keyboardType = .numberPad
          addDoneButtonToNumberPad()
          
         
          setupTapGesture()
          
       
    }

      @objc private func dismissKeyboard() {
          view.endEditing(true)
      }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == textfieldNumber {
     
                let currentText = (textField.text ?? "") as NSString
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                
             
                let phoneRegex = "^[+]?[0-9]{0,12}$"
                let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
                
                return predicate.evaluate(with: updatedText)
            }
            
            return true
        }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapOutside(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    
    private func addDoneButtonToNumberPad() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: NSLocalizedString("done", comment: "Готово"),
            style: .done,
            target: self,
            action: #selector(dismissKeyboard)
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpace, doneButton]
        
        textfieldNumber.inputAccessoryView = toolbar
    }

    @objc func openCalendarView() {
        
        let calendarView = UIView()
        calendarView.backgroundColor = .white
        calendarView.layer.cornerRadius = 10
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.tag = 100

        let calendar = UICalendarView()
        calendar.availableDateRange = DateInterval(
            start: Date(),
            end: Calendar.current.date(byAdding: .year, value: 1, to: Date())!
        )
        calendar.translatesAutoresizingMaskIntoConstraints = false


        let singleDateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendar.selectionBehavior = singleDateSelection

        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle(NSLocalizedString("okButton", comment: "ОК"), for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmDateSelection(_:)), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle(NSLocalizedString("cancelButton", comment: "Отмена"), for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissCalendarView), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        let buttonStack = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false

        calendarView.addSubview(calendar)
        calendarView.addSubview(buttonStack)
        view.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            calendarView.widthAnchor.constraint(equalToConstant: 350),
            calendarView.heightAnchor.constraint(equalToConstant: 400),

            calendar.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 10),
            calendar.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 10),
            calendar.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -10),
            calendar.heightAnchor.constraint(equalToConstant: 300),

            buttonStack.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 10),
            buttonStack.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor),
            buttonStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


    
    @objc func confirmDateSelection(_ sender: UIButton) {
        guard let selectedDate = selectedDate else {
            let alert = UIAlertController(
                title: NSLocalizedString("errorTitle", comment: "Ошибка"),
                message: NSLocalizedString("errorSelectDate", comment: "Выберите дату для продолжения"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: NSLocalizedString("okButton", comment: "ОК"), style: .default))
            present(alert, animated: true)
            return
        }
        

        dismissCalendarView()
        selectTime(for: selectedDate)
    }
    func selectTime(for date: Date) {
        let datePickerView = UIView()
        datePickerView.backgroundColor = .white
        datePickerView.layer.cornerRadius = 10
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.tag = 101

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.minimumDate = getDateWith(hour: 9, minute: 0, for: date)
        datePicker.maximumDate = getDateWith(hour: 18, minute: 0, for: date)
        datePicker.locale = Locale.current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle(NSLocalizedString("okButton", comment: "ОК"), for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmTimeSelection(_:)), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle(NSLocalizedString("cancelButton", comment: "Отмена"), for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissDatePicker), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        let buttonStack = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false

        datePickerView.addSubview(datePicker)
        datePickerView.addSubview(buttonStack)
        view.addSubview(datePickerView)

        self.currentDatePicker = datePicker

        NSLayoutConstraint.activate([
            datePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            datePickerView.widthAnchor.constraint(equalToConstant: 300),
            datePickerView.heightAnchor.constraint(equalToConstant: 350),

            datePicker.topAnchor.constraint(equalTo: datePickerView.topAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: datePickerView.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: datePickerView.trailingAnchor, constant: -10),

            buttonStack.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: datePickerView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: datePickerView.trailingAnchor),
            buttonStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    @objc func confirmTimeSelection(_ sender: UIButton) {
        guard let datePicker = currentDatePicker else { return }

        selectedTime = datePicker.date
        updateDateTimeTitle()
        dismissDatePicker()
    }

    
    func updateDateTimeTitle() {
        guard let selectedDate = selectedDate, let selectedTime = selectedTime else { return }
        
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        
        if let finalDate = calendar.date(from: dateComponents) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let formattedDate = formatter.string(from: finalDate)
            buttonSelectDateTime.setTitle(formattedDate, for: .normal)
        }
    }
    
    @objc func dismissCalendarView() {
        if let calendarView = view.viewWithTag(100) {
            calendarView.removeFromSuperview()
        }
    }
    
    @objc func dismissDatePicker() {
        if let datePickerView = view.viewWithTag(101) {
            datePickerView.removeFromSuperview()
        }
    }
    private func getDateWith(hour: Int, minute: Int, for date: Date) -> Date? {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)
    }
    @IBAction func tappedNext(_ sender: Any) {
        fetchAllRecords(ofType: Order.self)

        guard let serviceName = selectedService,
              let customerName = textfieldYourName.text, !customerName.isEmpty,
              let carBrand = textfieldCarBrand.text, !carBrand.isEmpty,
              let phoneNumber = textfieldNumber.text, !phoneNumber.isEmpty,
              let dateTime = buttonSelectDateTime.title(for: .normal), dateTime != NSLocalizedString("buttonSelect", comment: "") else {
            
            let alert = UIAlertController(
                title: NSLocalizedString("errorTitle", comment: "Ошибка"),
                message: NSLocalizedString("errorFillAllFields", comment: "Пожалуйста, заполните все поля"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: NSLocalizedString("okButton", comment: "ОК"), style: .default))
            present(alert, animated: true)
            return
        }
        
        let order = Order()
        order.serviceName = serviceName
        order.customerName = customerName
        order.carBrand = carBrand
        order.phoneNumber = phoneNumber
        order.dateTime = dateTime
        
        saveOrderToRealm(order: order)
    }

   private func saveOrderToRealm(order: Order) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(order)
            }
            print("Заказ успешно сохранен")
            openNextViewController()
        } catch {
            print("Ошибка сохранения в Realm: \(error)")
            showErrorAlert()
        }
    }

 

    private func openNextViewController() {
      
        let storyboard = UIStoryboard(name: "RequestFinishSubmit", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "RequestFinishSubmitViewController") as? RequestFinishSubmitViewController else {
            print("Ошибка: не удалось загрузить OrderDetailsViewController")
            return
        }
        
        nextViewController.ParentNavigationController = navigationController
        
     
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func fetchAllRecords<T: Object>(ofType type: T.Type) {
        do {
            let realm = try Realm()
            let results = realm.objects(type)
            print("Всего записей: \(results.count)")
            results.forEach { record in
                print(record)
            }
        } catch {
            print("Ошибка извлечения записей из Realm: \(error)")
        }
    }
    @IBAction func tappedBack(_ sender: Any) {
       
              ParentNavigationController?.popViewController(animated: true)
          
        
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("errorTitle", comment: "Ошибка"),
            message: NSLocalizedString("errorSavingOrder", comment: "Не удалось сохранить заказ"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: NSLocalizedString("okButton", comment: "ОК"), style: .default))
        present(alert, animated: true)
    }
   

}

extension RequestSubmitViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents else {
            print("Дата не выбрана")
            return
        }

        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            selectedDate = date
            print("Выбрана дата: \(date)")
        }
    }

    func dateSelection(_ selection: UICalendarSelectionSingleDate, didDeselectDate dateComponents: DateComponents?) {

        print("Дата снята с выбора")
    }
}


