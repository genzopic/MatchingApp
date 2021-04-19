//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/16.
//

import UIKit
//
import RxSwift
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class RegisterViewController: UIViewController {
    
    private let disposeBug = DisposeBag()
    private let viewModel = RegiserViewModel()
 
    // MARK: UIViews
    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "Email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let registerButton = RegisterButton(text: "登録")
    private let alredyHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "既にアカウントをお持ちの方はこちら")

    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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

        let baseStackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(baseStackView)
        self.view.addSubview(alredyHaveAccountButton)

        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPadding: 20)
        baseStackView.anchor(left:view.leftAnchor,
                             right: view.rightAnchor,
                             centerY: view.centerYAnchor,
                             leftPadding: 40,
                             rightPadding: 40)
        nameTextField.anchor(height:45)
        alredyHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: self.view.centerXAnchor, topPadding: 20)

    }
    //
    private func setupBindings() {
        
        // textFieldのbinding
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textの情報をハンドルする
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBug)

        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textの情報をハンドルする
                self?.viewModel.emailTextInput.onNext(text ?? "")

            }
            .disposed(by: disposeBug)

        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textの情報をハンドルする
                self?.viewModel.passwordTextInput.onNext(text ?? "")

            }
            .disposed(by: disposeBug)
        
        // buttonのbindings
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] (_) in
                // 登録時の処理
                self?.createUser()
            }
            .disposed(by: disposeBug)
        
        alredyHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let loginViewController = LoginViewController()
                self?.navigationController?.pushViewController(loginViewController, animated: true)
            }
            .disposed(by: disposeBug)

        // viewModelのbinding
        viewModel.validRegisterDriver
            .drive { (validAll) in
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBug)

    }
    
    private func createUser() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        HUD.show(.progress)
        
        Auth.createUserToFireAuth(email: email, password: password, name: name) { success in
            HUD.hide()
            if success == true {
                print("処理が完了")
                self.dismiss(animated: true, completion: nil)
             } else {
                
            }
        }
    }
    
    
}
