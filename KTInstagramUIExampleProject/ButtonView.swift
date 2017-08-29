//
//  ButtonView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    var heartButton: UIButton!
    var commentButton: UIButton!
    var shareButton: UIButton!
    var bookmarkButton: UIButton!
    
    override func performLayout() {
        // Heart Button
        heartButton = UIButton(topInset: 13, leftInset: 14, width: 24, height: 22)
        heartButton.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
        heartButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(heartButton)
        
        // Comment Button
        commentButton = UIButton(topInset: 13, leftInset: 55, width: 24, height: 22)
        commentButton.setImage(#imageLiteral(resourceName: "Comment"), for: .normal)
        commentButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(commentButton)
        
        // Share Button
        shareButton = UIButton(topInset: 13, leftInset: 94, width: 24, height: 22)
        shareButton.setImage(#imageLiteral(resourceName: "Message"), for: .normal)
        shareButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(shareButton)
        
        // Bookmark Button
        bookmarkButton = UIButton(topInset: 13, leftInset: 343, width: 24, height: 22)
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark"), for: .normal)
        bookmarkButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(bookmarkButton)
    }
}

