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
        stackView.anchor(top:view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
             

    }


}

