//
//  ProfileImageView.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/19.
//

import UIKit

class ProfileImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        self.image = UIImage(named: "")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 90
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
