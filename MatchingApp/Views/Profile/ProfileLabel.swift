//
//  ProfileLabel.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/19.
//

import UIKit

class ProfileLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: 45, weight: .bold)
        self.textColor = .black
        
    }
    
    // infoCollectionViewCellのタイトルラベル
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.textColor = .darkGray
        self.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
