import UIKit


class SplashViewController: UIViewController {
   
 
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_background_small")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
         
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rotatingImageView: UIImageView = {
        let imageView = UIImageView()
        if UIDevice.current.userInterfaceIdiom == .pad {
            imageView.image = UIImage(named: "logo_loader")
        }else{
            imageView.image = UIImage(named: "logo_loader_small")
        }
        imageView.contentMode = .left
            
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        startRotatingAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                    self.transitionToMainScreen()
                }
    }
    
    func setupLayout() {
        view.backgroundColor = UIColor.init(hex: "0x0A0E3F")

        view.addSubview(logoImageView)
        view.addSubview(rotatingImageView)
        if UIDevice.current.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([
        
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                logoImageView.widthAnchor.constraint(equalToConstant: 570),
                logoImageView.heightAnchor.constraint(equalToConstant: 570),
        
                rotatingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                rotatingImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 140),
                rotatingImageView.widthAnchor.constraint(equalToConstant: 133),
                rotatingImageView.heightAnchor.constraint(equalToConstant: 133)
            ])
           
        }else{
            NSLayoutConstraint.activate([
        
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                logoImageView.widthAnchor.constraint(equalToConstant: 370),
                logoImageView.heightAnchor.constraint(equalToConstant: 370),
        
                rotatingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                rotatingImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
                rotatingImageView.widthAnchor.constraint(equalToConstant: 69),
                rotatingImageView.heightAnchor.constraint(equalToConstant: 69)
            ])
        }
        
    }

    func startRotatingAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * CGFloat.pi
        rotation.duration = 1.0
        rotation.repeatCount = Float.infinity
        rotatingImageView.layer.add(rotation, forKey: "rotate")
    }
    
    private func transitionToMainScreen() {
            guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows.first else { return }

            let storyboard = UIStoryboard(name: "OnboardingPrivacy", bundle: nil)
            guard let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingPrivacy") as? OnboardingViewController else {
                print("Ошибка: Не удалось найти OnboardingViewController в Storyboard.")
                return
            }

           
            let navigationController = UINavigationController(rootViewController: onboardingViewController)
        
        if OnboardingManager.isOnboardingCompleted() {
         
                let storyboard = UIStoryboard(name: "MainWindow", bundle: nil)
                let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                navigationController.viewControllers = [mainVC]
            } else {
           
                let storyboard = UIStoryboard(name: "OnboardingPrivacy", bundle: nil)
                let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingPrivacy") as! OnboardingViewController
                onboardingVC.ParentNavigationController = navigationController
                navigationController.viewControllers = [onboardingVC]
            }
        
        
        
    
            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    window.rootViewController = navigationController
                },
                completion: nil
            )
        }
}

