//
//  ProfileViewController.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/19.
//

import UIKit

class ProfileViewController: UIViewController {
    //
    var user: User?

    // UI
    private let saveButoon = UIButton(type: .system).createProfileTopButton(title: "保存")
    private let logoutButton = UIButton(type: .system).createProfileTopButton(title: "ログアウト")
    private let profileImageView = ProfileImageView()
    private let nameLabel = ProfileLabel()
    private let profileEditButton = UIButton(type: .system).createProfileEditButton()
    private lazy var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let  cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemBackground
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        profileImageView.image = UIImage(named: "person")
        nameLabel.text = "Test, 21"
        
        // viewの配置を設定
        self.view.addSubview(saveButoon)
        self.view.addSubview(logoutButton)
        self.view.addSubview(profileImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(profileEditButton)
        self.view.addSubview(infoCollectionView)
        
        saveButoon.anchor(top: view.topAnchor, left: view.leftAnchor,topPadding: 20, leftPadding: 15)
        logoutButton.anchor(top:view.topAnchor,right: view.rightAnchor, topPadding: 20, rightPadding: 15)
        profileImageView.anchor(top:view.topAnchor, centerX: view.centerXAnchor, width: 180, height: 180, topPadding: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        profileEditButton.anchor(top: profileImageView.topAnchor, right: profileImageView.rightAnchor, width: 60, height: 60)
        infoCollectionView.anchor(top: nameLabel.bottomAnchor,bottom: view.bottomAnchor, left:view.leftAnchor, right: view.rightAnchor, topPadding: 20)

        // ユーザー情報を反映
        nameLabel.text = user?.name
        
        
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        cell.user = self.user
//        cell.nameTextField.text = user?.name
//        cell.emailTextField.text = user?.email
        return cell
    }
    
}

