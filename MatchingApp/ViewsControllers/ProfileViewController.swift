//
//  ProfileViewController.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/19.
//

import UIKit
//
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import RxSwift
import RxCocoa
import PKHUD
import Nuke

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    private let disposeBag = DisposeBag()
    
    // カメラorアルバムの許可チェッククラス
    var checkPermission = CheckPermission()
    //
    var user: User?

    // UIViews
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
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // カメラorアルバムの使用確認
        checkPermission.checkCamera()

        setupLayout()
        setupBindings()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Methods
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
        
        saveButoon.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,topPadding: 20, leftPadding: 15)
        logoutButton.anchor(top:view.safeAreaLayoutGuide.topAnchor,right: view.rightAnchor, topPadding: 20, rightPadding: 15)
        profileImageView.anchor(top:view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor, width: 180, height: 180, topPadding: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        profileEditButton.anchor(top: profileImageView.topAnchor, right: profileImageView.rightAnchor, width: 60, height: 60)
        infoCollectionView.anchor(top: nameLabel.bottomAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, left:view.leftAnchor, right: view.rightAnchor, topPadding: 20,bottomPadding: 20)
        
        // ユーザー情報を反映
        nameLabel.text = user?.name
        if let url = URL(string: user?.profileImageUrl ?? "" ) {
            Nuke.loadImage(with: url, into: profileImageView)
        }
        
    }
    
    //
    private func setupBindings() {
        
        // プロフィール編集ボタン
        profileEditButton.rx.tap
            .asDriver()
            .drive { [weak self] (_) in
                // TODO: アルバム選択
                // 写真アルバムを表示する
                let SourceType:UIImagePickerController.SourceType = .photoLibrary
                self?.createImagePicker(sourceType: SourceType)

            }
            .disposed(by: disposeBag)

        
        // 保存ボタン
        saveButoon.rx.tap
            .asDriver()
            .drive { [weak self] (_) in
                // TODO:入力項目チェック
                
                
                HUD.show(.progress)
                let image = self?.profileImageView.image
                guard let uploadImage = image?.jpegData(compressionQuality: 0.3) else { return }
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let fileName = "\(uid + String(Date().timeIntervalSince1970)).jpg"
                let storageRef = Storage.storage().reference().child("profile_image").child(fileName)
                storageRef.putData(uploadImage, metadata: nil) { (metadata, error) in
                    if let err = error {
                        print("save image err: ",err.localizedDescription)
                        HUD.hide()
                        return
                    }
                    storageRef.downloadURL { (url, error) in
                        if let err = error {
                            print("download image err: ",err.localizedDescription)
                            HUD.hide()
                            return
                        }
                        guard let urlString = url?.absoluteString else { return }
                        self?.user?.profileImageUrl = urlString
                        // Firestoreにユーザー情報に保存する
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                        guard let user = self?.user else { return }
                        Firestore.setUserDataToFirestore(uid: uid, user: user) { (result) in
                            print("result: ", result)
                            HUD.hide()
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                }

                
            }
            .disposed(by: disposeBag)

        
        // ログアウトボタン
        logoutButton.rx.tap
            .asDriver()
            .drive { (_) in
                do {
                    try Auth.auth().signOut()
                    self.dismiss(animated: true, completion: nil)

                } catch {
                    print("ログアウトに失敗", error)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    //
    private func setupBindings(cell: InfoCollectionViewCell) {
        cell.nameTextField.rx.text
            .asDriver()
            .drive { [weak self] (text) in
                self?.user?.name = text ?? ""
            }
            .disposed(by: disposeBag)
        
        cell.emailTextField.rx.text
            .asDriver()
            .drive { [weak self] (text) in
                self?.user?.email = text ?? ""

            }
            .disposed(by: disposeBag)
        
        cell.ageTextField.rx.text
            .asDriver()
            .drive { [weak self] (text) in
                guard let text = text else { return }
                self?.user?.age = Int(text) ?? 0

            }
            .disposed(by: disposeBag)
        
        cell.regidenceTextField.rx.text
            .asDriver()
            .drive { [weak self] (text) in
                self?.user?.regidence = text ?? ""

            }
            .disposed(by: disposeBag)
        
        cell.hobbyTextField.rx.text
            .asDriver()
            .drive { [weak self] (text) in
                self?.user?.hobby = text ?? ""

            }
            .disposed(by: disposeBag)

        cell.introductionTextField.rx.text
            .asDriver()
            .drive { [weak self] (text) in
                self?.user?.introduction = text ?? ""

            }
            .disposed(by: disposeBag)

    }
    
}

// MARK: - CollectionView
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        cell.user = self.user
        
        setupBindings(cell: cell)
        
        return cell
    }
    
}

// MARK: アルバム・カメラを起動して選択
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // カメラorアルバムを起動する
    func createImagePicker(sourceType:UIImagePickerController.SourceType) {
        let cameraPicker = UIImagePickerController()
        cameraPicker.sourceType = sourceType
        cameraPicker.delegate = self
        cameraPicker.allowsEditing = true
        self.present(cameraPicker, animated: true, completion: nil)
    }

    // 撮影orアルバムがキャンセルされたとき
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // カメラorアルバムを閉じる
        picker.dismiss(animated: true, completion: nil)
    }

    // 撮影完了or選択完了されたとき
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // info[.editedImage] に撮影or選択されたものが格納されている
        // 空でない場合に変数に入れつつ
        if let pickerImage = info[.editedImage] as? UIImage{
            profileImageView.image = pickerImage
            // カメラorアルバムを閉じる
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
