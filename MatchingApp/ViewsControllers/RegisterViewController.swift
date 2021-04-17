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

class RegisterViewController: UIViewController {
    
    private let disposeBug = DisposeBag()
    private let viewModel = RegisterViewModel()
    
    
    // MARK: UIViews
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "Email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let registerButton = RegisterButton()

    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindings()
        
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

        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPadding: 20)
        baseStackView.anchor(left:view.leftAnchor,
                             right: view.rightAnchor,
                             centerY: view.centerYAnchor,
                             leftPadding: 40,
                             rightPadding: 40)
        nameTextField.anchor(height:45)

    }
    //
    private func setupBindings() {
        
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
        
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] (_) in
                // 登録時の処理
                self?.createUserToFireAuth()
            }
            .disposed(by: disposeBug)

    }
    
    private func createUserToFireAuth() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("auth createUser err: ", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            print("auth createUser Success uid: ",uid)
            self.setUserDataToFirestore(uid: uid,email: email)
            
            
        }
        
    }
    
    private func setUserDataToFirestore(uid: String, email: String) {
        guard let name = nameTextField.text else { return }
        let doc = [
            "name": name,
            "email": email,
            "creatAt": Timestamp()
        ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).setData(doc) { (err) in
            if let err = err {
                print("set firestore err: ",err)
                return
            }
            print("set firestore success uid: ", uid)
            
        }
        
        
    }
    
}
