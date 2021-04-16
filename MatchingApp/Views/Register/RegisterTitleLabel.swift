//
//  RegisterTitleLabel.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/16.
//

import UIKit

class RegisterTitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        text = "Tinder"
        font = .boldSystemFont(ofSize: 80)
        textColor = .white
        textAlignment = .center

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
