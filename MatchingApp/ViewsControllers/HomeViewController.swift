//
//  ViewController.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/13.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let registerViewController = RegisterViewController()
            registerViewController.modalPresentationStyle = .fullScreen
            self.present(registerViewController, animated: true, completion: nil)
        }

    }
    
    private func setupLayout() {
        
        self.view.backgroundColor = .systemBackground
        
        let topControlView = TopControlView()
        topControlView.anchor(height:100)

        let cardView = CardView()

        let bottomControllView = BottomControlView()
        bottomControllView.anchor(height:120)
        
        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControllView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)
        stackView.anchor(top:view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor)

    }


}

