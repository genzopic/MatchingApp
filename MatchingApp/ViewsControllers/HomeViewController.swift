//
//  ViewController.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/13.
//

import UIKit
//
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    private var user: User?
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()
    
    // MARK: - Life Cicle Methods
    // 初期表示時
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.fetchUserFromFirestore(uid: uid) { (user) in
            if let user = user {
                self.user = user
                
            }
        }
        
    }
    
    // 画面に表示された直後に呼ばれます
    // viewDidLoadとは異なり毎回呼び出されます
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser?.uid == nil {
            let registerViewController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Methods
    
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
        self.view.addSubview(logoutButton)
        
        stackView.anchor(top:view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor)
        logoutButton.anchor(bottom:view.bottomAnchor,left:view.leftAnchor,bottomPadding: 10, leftPadding: 10)
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
        
    }
    
    @objc private func tappedLogoutButton() {
        do {
            try Auth.auth().signOut()
            let registerViewController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)

        } catch {
            print("ログアウトに失敗", error)
        }
    }
    
    
}

