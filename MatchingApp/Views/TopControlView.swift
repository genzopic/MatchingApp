//
//  TopControlView.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/14.
//

import UIKit
//
import RxCocoa
import RxSwift

class TopControlView: UIView {
    
    private let disposeBag = DisposeBag()
    
    let tinderButton = createTopButton(imageName: "fire-selected", unselectedImage: "fire-unselected")
    let goodButton = createTopButton(imageName: "good-selected", unselectedImage: "good-unselected")
    let commentButton = createTopButton(imageName: "comment-selected", unselectedImage: "comment-unselected")
    let profileButton = createTopButton(imageName: "profile-selected", unselectedImage: "profile-unselected")

    static private func createTopButton(imageName: String,unselectedImage: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .selected)
        button.setImage(UIImage(named: unselectedImage), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupBindings()

    }
    
    private func setupLayout() {

        let baseStackView = UIStackView(arrangedSubviews: [tinderButton,goodButton,commentButton,profileButton])
        addSubview(baseStackView)
        
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 35
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        baseStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true

    }
    
    private func setupBindings() {
        
        tinderButton.rx.tap
            .subscribe { (_) in
                self.handleSelectedButton(selectedButton: self.tinderButton)
            }
            .disposed(by: disposeBag)

        goodButton.rx.tap
            .subscribe { (_) in
                self.handleSelectedButton(selectedButton: self.goodButton)
            }
            .disposed(by: disposeBag)

        commentButton.rx.tap
            .subscribe { (_) in
                self.handleSelectedButton(selectedButton: self.commentButton)
            }
            .disposed(by: disposeBag)

        profileButton.rx.tap
            .subscribe { (_) in
                self.handleSelectedButton(selectedButton: self.profileButton)
            }
            .disposed(by: disposeBag)
        
        tinderButton.isSelected = true
        
    }
    
    private func handleSelectedButton(selectedButton: UIButton) {
        let buttons = [tinderButton,goodButton,commentButton,profileButton]
        
        buttons.forEach { button in
            if button == selectedButton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

