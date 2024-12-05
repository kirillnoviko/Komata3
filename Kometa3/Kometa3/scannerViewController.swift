import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    let targetQRCodeString = "didkjdhfjfkdjfnfkfifidisj448475849JjJjjJjK86793"
    var isProcessing = false // Флаг для предотвращения повторной обработки
    var shouldShowSettingsAlert = false // Флаг для показа предупреждения о настройках

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCameraPreview()
        setupBackButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkCameraAuthorization()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Показываем предупреждение только после загрузки экрана
        if shouldShowSettingsAlert {
            shouldShowSettingsAlert = false
            showSettingsAlert()
        }
    }

    func setupCameraPreview() {
        previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer) // Добавляем слой камеры как задний план
    }

    func checkCameraAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            setupCamera() // Если доступ разрешен, запускаем камеру
        case .notDetermined:
            requestCameraAccess() // Если доступ не определен, запрашиваем
        case .denied, .restricted:
            // Устанавливаем флаг для показа предупреждения
            shouldShowSettingsAlert = true
        @unknown default:
            print("Неизвестный статус авторизации")
        }
    }

    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    self.setupCamera()
                } else {
                    // Устанавливаем флаг для показа предупреждения
                    self.shouldShowSettingsAlert = true
                }
            }
        }
    }

    func showSettingsAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("titleAllertSetting", comment: "Текст для кнопки назад"),
            message: NSLocalizedString("settingAllertSetting", comment: "Текст для кнопки назад"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: NSLocalizedString("settingSetting", comment: "Текст для кнопки назад"), style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancelAlert", comment: "Текст для кнопки назад"), style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    func setupCamera() {
        if captureSession != nil {
            captureSession.startRunning()
            return
        }

        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Error initializing camera input: \(error)")
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Could not add video input to capture session")
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Could not add metadata output to capture session")
            return
        }

        previewLayer.session = captureSession
        captureSession.startRunning()
    }

    func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle (NSLocalizedString("backAlert", comment: "Текст для кнопки назад"), for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backButton.backgroundColor = .systemBlue
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 8
        backButton.frame = CGRect(x: 20, y: 50, width: 100, height: 40)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(backButton) // Добавляем кнопку поверх слоя камеры
    }

    @objc func goBack() {
        captureSession?.stopRunning()
        dismiss(animated: true, completion: nil)
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !isProcessing else { return } // Предотвращаем повторную обработку
        isProcessing = true

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            checkQRCode(stringValue)
        } else {
            isProcessing = false // Снимаем флаг, если ничего не найдено
        }
    }

    func checkQRCode(_ code: String) {
        if code == targetQRCodeString {
            showResult(message: NSLocalizedString("QRCodeSucces", comment: "Текст для кнопки назад"), isSuccess: true)
        } else {
            showResult(message: NSLocalizedString("QRCodeError", comment: "Текст для кнопки назад"), isSuccess: false)
        }
    }

    func showResult(message: String, isSuccess: Bool) {
        // Полупрозрачный слой для сообщения
        let messageView = UIView(frame: view.bounds)
        messageView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        messageView.tag = 1001 // Уникальный тег для предотвращения дублирования

        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.frame = CGRect(x: 20, y: view.bounds.height / 2 - 50, width: view.bounds.width - 40, height: 50)
        messageView.addSubview(label)

        let okButton = UIButton(type: .system)
        okButton.setTitle("ОК", for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        okButton.backgroundColor = .systemBlue
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius = 8
        okButton.frame = CGRect(x: view.bounds.width / 2 - 50, y: view.bounds.height / 2 + 20, width: 100, height: 40)
        okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)
        okButton.tag = isSuccess ? 1 : 0
        messageView.addSubview(okButton)

        view.viewWithTag(1001)?.removeFromSuperview() // Удаляем предыдущее сообщение, если оно есть
        view.addSubview(messageView)
    }

    @objc func okButtonTapped(_ sender: UIButton) {
        sender.superview?.removeFromSuperview()
        isProcessing = false // Снимаем флаг обработки

        if sender.tag == 1 {
            // Успешное сканирование, возвращаемся на главный экран
            dismiss(animated: true, completion: nil)
        } else {
            // Если неудачное сканирование, продолжаем работу камеры
            captureSession.startRunning()
        }
    }
}
