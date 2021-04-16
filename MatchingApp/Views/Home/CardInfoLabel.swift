//
//  CardInfoLabel.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/16.
//

import UIKit

class CardInfoLabel: UILabel {

    // NOPE,GOOD LABEL
    init(text: String,textColor: UIColor) {
        super.init(frame: .zero)
        
        font = .systemFont(ofSize: 40, weight: .bold)
        self.textColor = textColor
        self.text = text
        textAlignment = .center
        layer.borderWidth = 3
        layer.borderColor = textColor.cgColor
        layer.cornerRadius = 10
        alpha = 0
        
    }
    
    // OTHER LABEL
    init(text: String,font: UIFont) {
        super.init(frame: .zero)
        
        self.font = font
        textColor = .white
        self.text = text

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
