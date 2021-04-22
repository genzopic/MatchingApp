//
//  LoginViewController.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/18.
//

import UIKit
//
import FirebaseAuth
import RxSwift
import PKHUD

class LoginViewController: UIViewController {

    private let disposeBug = DisposeBag()
    
    // MARK: UIViews
    private let titleLabel = RegisterTitleLabel(text: "Login")
    private let emailTextField = RegisterTextField(placeHolder: "Email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let loginButton = RegisterButton(text: "ログイン")
    private let dontHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "アカウントをお持ちでない方はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindings()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Methods
    private func setupGradientLayer() {
        
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        
        layer.colors = [startColor,endColor]
        layer.locations = [0.0,1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        
    }
    //
    private func setupLayout() {
        
        passwordTextField.isSecureTextEntry = true

        let baseStackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(baseStackView)
        self.view.addSubview(dontHaveAccountButton)
        
        emailTextField.anchor(height: 45)
        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPadding: 20)
        baseStackView.anchor(left:view.leftAnchor,
                             right: view.rightAnchor,
                             centerY: view.centerYAnchor,
                             leftPadding: 40,
                             rightPadding: 40)
        dontHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: self.view.centerXAnchor, topPadding: 20)

    }
    //
    private func setupBindings() {
        
        dontHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBug)

        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.login()
            }
            .disposed(by: disposeBug)

        
    }
    //
    private func login() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        HUD.show(.progress)
        Auth.loginWithFireAuth(email: email, password: password) { (success) in
            HUD.hide()
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                
            }
        }

    }
    

}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
