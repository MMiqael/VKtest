//
//  EnterController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 19.11.2020.
//

import UIKit
import Firebase

class EnterController: UIViewController {
    
    private var handle: AuthStateDidChangeListenerHandle!
    
    private var gradient: CAGradientLayer!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vkLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButtonOutlet: UIButton!
    
    override func viewDidLayoutSubviews() {
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient = CAGradientLayer()
        view.layer.insertSublayer(gradient, at: 0)

        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        setupConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
            // Второе — когда она пропадает
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user != nil {
                self.performSegue(withIdentifier: EnumSegueIdentifiers.fromEnter.rawValue, sender: nil)
                self.loginTextField.text = nil
                self.passwordTextField.text = nil
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }

    @IBAction func enterButtonAction(_ sender: Any) {
//        let login = loginTextField.text
//        let password = passwordTextField.text
//
//        if (login == "admin@gmail.com" || login == "89991234567") && password == "123456" {
//            enterButtonOutlet.backgroundColor = .systemGreen
//            timer?.invalidate()
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
//                self.performSegue(withIdentifier: EnumSegueIdentifiers.fromEnter.rawValue, sender: self)
//            })
//        } else {
//            let alert = UIAlertController(title: nil, message: "Неверный логин или пароль, попробуйте снова", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(ok)
//            present(alert, animated: true, completion: nil)
//        }
        
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              email.count > 0,
              password.count > 0
        else {
            showAlert(title: "Ошибка авторизации", message: "Неверный логин или пароль")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                self?.showAlert(title: "Ошибка авторизации", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let alert = UIAlertController(title: "Регистрация", message: "Заполните данные для регистрации", preferredStyle: .alert)
        
        alert.addTextField { email in
            email.placeholder = "Введите электронную почту"
        }
        
        alert.addTextField { password in
            password.placeholder = "Ведите пароль"
        }
        
        let signUpButton = UIAlertAction(title: "Зарегистрироваться", style: .default) { (action) in
            
            guard let emailField = alert.textFields?[0],
                  let passwordField = alert.textFields?[1],
                  let email = emailField.text,
                  let password = passwordField.text
            else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                if let error = error {
                    self?.showAlert(title: "Ошибка регистрации", message: error.localizedDescription)
                } else {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alert.addAction(signUpButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logInWithVK(_ sender: Any) {
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Setup Configuration
    private func setupConfig() {
        gradient.startPoint = CGPoint(x: 0.4, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        let startColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]
        gradient.locations = [0, 1]
        
        vkLabel.textColor = .white
        vkLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        loginTextField.font = UIFont.systemFont(ofSize: 16)
        loginTextField.textColor = .black
        loginTextField.tintColor = .white
        loginTextField.clearButtonMode = .whileEditing
        
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.textColor = .black
        passwordTextField.tintColor = .white
        passwordTextField.clearButtonMode = .whileEditing
        
        enterButtonOutlet.setTitle("Войти", for: .normal)
        enterButtonOutlet.setTitleColor(.white, for: .normal)
        enterButtonOutlet.backgroundColor = .systemBlue
    }
}

// MARK: - Extension

extension EnterController {
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
            self.scrollView?.endEditing(true)
        }

}

