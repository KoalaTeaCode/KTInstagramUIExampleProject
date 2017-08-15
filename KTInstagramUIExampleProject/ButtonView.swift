//
//  ButtonView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    let heartButton = UIButton()
    let commentButton = UIButton()
    let shareButton = UIButton()
    let bookmarkButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Heart Button
        heartButton.frame = CGRect(x: 14.calculateWidth(), y: 12.calculateHeight(), width: 24.calculateHeight(), height: 24.calculateHeight())
        heartButton.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
        self.addSubview(heartButton)
        
        // Comment Button
        commentButton.frame = CGRect(x: 55.calculateWidth(), y: 12.calculateHeight(), width: 24.calculateHeight(), height: 24.calculateHeight())
        commentButton.setImage(#imageLiteral(resourceName: "Comment"), for: .normal)
        self.addSubview(commentButton)
        
        // Share Button
        shareButton.frame = CGRect(x: 94.calculateWidth(), y: 12.calculateHeight(), width: 24.calculateHeight(), height: 24.calculateHeight())
        shareButton.setImage(#imageLiteral(resourceName: "Message"), for: .normal)
        self.addSubview(shareButton)
        
        // Bookmark Button
        bookmarkButton.frame = CGRect(x: 343.calculateWidth(), y: 12.calculateHeight(), width: 24.calculateHeight(), height: 24.calculateHeight())
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark"), for: .normal)
        self.addSubview(bookmarkButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
