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
        
        let view1 = TopControlView()
        
        let view2 = UIView()
        view2.backgroundColor = .blue

        let bottomControllView = BottomControlView()
//        view3.backgroundColor = .green

        let stackView = UIStackView(arrangedSubviews: [view1,view2,bottomControllView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        self.view.addSubview(stackView)
        view1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        bottomControllView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        [
//            stackView.topAnchor.constraint(equalTo: view.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
//        ].forEach { $0.isActive = true }
     

    }


}

