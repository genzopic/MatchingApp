//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/16.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "Email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let registerButton = RegisterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .yellow
        
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
    
    private func setupGradientLayer() {
        
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        
        layer.colors = [startColor,endColor]
        layer.locations = [0.0,1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        
        
    }
    
    
    
}
