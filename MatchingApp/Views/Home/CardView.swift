//
//  CardView.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/15.
//

import UIKit

class CardView: UIView {
    
    let cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "test-image")
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Taro, 22"
        
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let regidenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "日本, 大阪"

        return label
        
    }()
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "ランニング"

        return label
        
    }()

    let introductionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "走り回るのが大好きです"

        return label
        
    }()

    let goodLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = UIColor.rgb(red: 137, green: 223, blue: 86)
        label.text = "GOOD"
        label.textAlignment = .center
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red: 137, green: 223, blue: 86).cgColor
        label.layer.cornerRadius = 10
        label.alpha = 0
        return label
    }()
    
    let nopeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = UIColor.rgb(red: 222, green: 110, blue: 110)
        label.text = "NOPE"
        label.textAlignment = .center
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red: 222, green: 110, blue: 110).cgColor
        label.layer.cornerRadius = 10
        label.alpha = 0
        return label
    }()
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
        
    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
//        print("gesture: ",gesture.debugDescription)
        let transeration = gesture.translation(in: self)
        if gesture.state == .changed {
            self.handlePanChange(transeration: transeration)
        } else if gesture.state == .ended {
            self.handlePanEnded()
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
    
    private func handlePanEnded() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: []) {
            self.transform = .identity
            self.goodLabel.alpha = 0
            self.nopeLabel.alpha = 0
            self.layoutIfNeeded()
        }

    }
    
    private func setupLayout() {
        
        let infoVerticalStackView = UIStackView(arrangedSubviews: [regidenceLabel,hobbyLabel,introductionLabel])
        infoVerticalStackView.axis = .vertical
        infoVerticalStackView.distribution = .fillEqually
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView,infoButton])
        baseStackView.axis = .horizontal
        
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

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
