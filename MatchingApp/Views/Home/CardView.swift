//
//  CardView.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/15.
//

import UIKit
//
import Nuke

class CardView: UIView {
    
    //
    private let gradientLayer = CAGradientLayer()
    
    // MARK: UIViews
    private let cardImageView = CardImageView(imageName: "test-image")
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    private let nameLabel = CardInfoLabel(text: "Taro, 22", font: .systemFont(ofSize: 40, weight: .heavy))
    private let regidenceLabel = CardInfoLabel(text: "日本, 大阪", font: .systemFont(ofSize: 20, weight: .regular))
    private let hobbyLabel = CardInfoLabel(text: "ランニング", font: .systemFont(ofSize: 25, weight: .regular))
    private let introductionLabel = CardInfoLabel(text: "走り回るのが大好きです", font: .systemFont(ofSize: 25, weight: .regular))
    private let goodLabel = CardInfoLabel(text: "GOOD", textColor: UIColor.rgb(red: 137, green: 223, blue: 86))
    private let nopeLabel = CardInfoLabel(text: "NOPE", textColor: UIColor.rgb(red: 222, green: 110, blue: 110))
    
    // MARK: -
    init(user: User) {
        super.init(frame: .zero)
        
        setupLayout(user: user)
        setupGradientLayer()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
        
    }
    
    // イメージの下を少し黒くして文字を見やすくする
    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.3,1.1]
        cardImageView.layer.addSublayer(gradientLayer)
    }
    // ビューが作成されて表示される前に呼ばれる
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
//        print("gesture: ",gesture.debugDescription)
        let transeration = gesture.translation(in: self)
        guard let view = gesture.view else { return }
        
        if gesture.state == .changed {
            self.handlePanChange(transeration: transeration)
        } else if gesture.state == .ended {
            self.handlePanEnded(view: view, transeration: transeration)
        }

    }
    
    private func handlePanChange(transeration: CGPoint) {
        let degree: CGFloat = transeration.x / 20       // 割る数を大きくすると、大きな円になる
        let angle = degree * .pi / 180                  // degree度を回転　（例：35度＝35 * CGFloat.pi / 180）
        let rotateTranselation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranselation.translatedBy(x: transeration.x, y: transeration.y)
        
        let ratio:CGFloat = 1 / 100
        let ratioValue = ratio * transeration.x
        if transeration.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else {
            self.nopeLabel.alpha = -ratioValue
        }
//        print("ratioValue: ",ratioValue)
        
    }
    
    private func handlePanEnded(view: UIView, transeration: CGPoint) {
        print("transeration.x: ", transeration.x)
        if transeration.x <= -120 {
            // 120以上左にカードをスワイプした時にカードを消す
            view.removeCardViewAnimation(x: -600)
            
        } else if transeration.x > 120 {
            // 120以上右にカードをスワイプした時にカードを消す
            view.removeCardViewAnimation(x: 600)
            
        } else {
            // 120未満のカードのスワイプは、カードを元の位置に戻す
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: []) {
                view.transform = .identity
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
                self.layoutIfNeeded()
            }

        }
        
    }
    
    private func setupLayout(user: User) {
        
        let infoVerticalStackView = UIStackView(arrangedSubviews: [regidenceLabel,hobbyLabel,introductionLabel])
        infoVerticalStackView.axis = .vertical
        infoVerticalStackView.distribution = .fillEqually
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView,infoButton])
        baseStackView.axis = .horizontal
        
        // Viewの配置を作成
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)

        cardImageView.anchor(top:topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10,rightPadding: 10)
        infoButton.anchor(width: 40 )
        baseStackView.anchor(bottom:cardImageView.bottomAnchor,left:cardImageView.leftAnchor,right: cardImageView.rightAnchor,bottomPadding: 20,leftPadding: 20,rightPadding: 20)
        nameLabel.anchor(bottom:baseStackView.topAnchor,left: cardImageView.leftAnchor,bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top:cardImageView.topAnchor,left: cardImageView.leftAnchor,width: 140, height: 55, topPadding: 25,leftPadding: 25)
        nopeLabel.anchor(top:cardImageView.topAnchor,right: cardImageView.rightAnchor,width: 140, height: 55, topPadding: 25,rightPadding: 25)

        // ユーザー情報をViewに反映
        addUserToCardView(user: user)
        
    }
    
    private func addUserToCardView(user: User) {
        if let url = URL(string: user.profileImageUrl) {
            Nuke.loadImage(with: url, into: cardImageView)
        }
        nameLabel.text = "\(user.name),\(user.age)"
        regidenceLabel.text = user.regidence
        hobbyLabel.text = user.hobby
        introductionLabel.text = user.introduction

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
