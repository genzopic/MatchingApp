//
//  CardImageView.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/16.
//

import UIKit

class CardImageView: UIImageView {
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        image = UIImage(named: imageName)
        backgroundColor = .blue
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
