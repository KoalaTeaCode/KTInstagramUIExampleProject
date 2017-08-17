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
        heartButton.frame = CGRect(x: 14.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        heartButton.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
        heartButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(heartButton)
        
        // Comment Button
        commentButton.frame = CGRect(x: 55.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        commentButton.setImage(#imageLiteral(resourceName: "Comment"), for: .normal)
        commentButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(commentButton)
        
        // Share Button
        shareButton.frame = CGRect(x: 94.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        shareButton.setImage(#imageLiteral(resourceName: "Message"), for: .normal)
        shareButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(shareButton)
        
        // Bookmark Button
        bookmarkButton.frame = CGRect(x: 343.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark"), for: .normal)
        bookmarkButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(bookmarkButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
