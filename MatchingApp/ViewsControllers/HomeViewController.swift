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
import PKHUD
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    // 自分のユーザー情報
    private var user: User?
    // 自分以外のユーザー情報
    private var users = [User]()
    
    // UIViews
    let topControlView = TopControlView()
    let cardView = UIView() // CardView()
    let bottomControllView = BottomControlView()
//    let logoutButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("ログアウト", for: .normal)
//        return button
//    }()
    
    // MARK: - Life Cicle Methods
    // 初期表示時
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBindings()
        
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("HomeViewController-viewWillAppear")

        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.fetchUserFromFirestore(uid: uid) { (user) in
            if let user = user {
                self.user = user
            }
        }
        // 自分以外のユーザ情報を取得する
        fetchUsers()
        
    }
    
    // 画面に表示された直後に呼ばれます
    // viewDidLoadとは異なり毎回呼び出されます
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("HomeViewController-viewDidAppear")
        if Auth.auth().currentUser?.uid == nil {
            let registerViewController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Methods
    private func fetchUsers() {
        HUD.show(.progress)
        Firestore.fetchUsersFromFirestore { (users) in
            HUD.hide()
            self.users = users
            print("ユーザー情報の取得に成功")
            // ユーザー情報をカードにセットする
            self.users.forEach { (user) in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
            }
            
            
        }
    }
    
    private func setupLayout() {
        
        self.view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControllView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)
//        self.view.addSubview(logoutButton)
        
        topControlView.anchor(height:100)
        bottomControllView.anchor(height:120)

        stackView.anchor(top:view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor)
        
//        logoutButton.anchor(bottom:view.bottomAnchor,left:view.leftAnchor,bottomPadding: 10, leftPadding: 10)
//        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
        
    }
    
//    @objc private func tappedLogoutButton() {
//        do {
//            try Auth.auth().signOut()
//            let registerViewController = RegisterViewController()
//            let nav = UINavigationController(rootViewController: registerViewController)
//            nav.modalPresentationStyle = .fullScreen
//            self.present(nav, animated: true, completion: nil)
//
//        } catch {
//            print("ログアウトに失敗", error)
//        }
//    }
    
    //
    private func setupBindings() {
        
        // プロフィールボタンをタップ
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] (_) in
                let profile = ProfileViewController()
                profile.user = self?.user
                profile.modalPresentationStyle = .fullScreen
                self?.present(profile, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        
        // リロードボタンをタップ
        bottomControllView.reloadView.button?.addTarget(self, action: #selector(tappedReloadButton), for: .touchUpInside)
        
        
    }
    
    @objc private func tappedReloadButton() {
        print("reloadButton tapped!!!!")
    }
    
}
