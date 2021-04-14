//
//  BottomControlView.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/13.
//

import UIKit

class BottomControlView: UIView {
    
    let reloadView = BottomButtonView(frame: .zero, width: 50, imageName: "reload")
    let nopeView = BottomButtonView(frame: .zero, width: 60, imageName: "nope")
    let superlikeView = BottomButtonView(frame: .zero, width: 50, imageName: "star")
    let likeView = BottomButtonView(frame: .zero, width: 60, imageName: "like")
    let boostView = BottomButtonView(frame: .zero, width: 50, imageName: "boost")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let baseStackView = UIStackView(arrangedSubviews: [reloadView,nopeView,superlikeView,likeView,boostView])
        addSubview(baseStackView)
        
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 10
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        baseStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true


        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// フッターの（ビューに配置した）ボタン
class BottomButtonView: UIView {

    // カスタムボタンで作成
    var button: BottomButton?
    
    init(frame: CGRect, width: CGFloat, imageName: String) {
        super.init(frame: frame)
        
        button = BottomButton(type: .custom)
        button?.setImage(UIImage(named: imageName)?.resize(size: CGSize(width: width * 0.7, height: width * 0.7)), for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width / 2
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.5
        button?.layer.shadowRadius = 15
        
        addSubview(button!)

        button?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button?.widthAnchor.constraint(equalToConstant: width).isActive = true
        button?.heightAnchor.constraint(equalToConstant: width).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// カスタムボタン（押すアニメーションを追加）
class BottomButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
