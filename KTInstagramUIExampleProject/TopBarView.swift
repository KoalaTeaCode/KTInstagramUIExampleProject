//
//  TopBarView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    let userImageView = UIImageView()
    let userLabel = UILabel()
    let ellipsesImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set user image frame
        // The user image needs to be a cirle so we use "calculateHeight" for both width and height
        userImageView.frame = CGRect(x: 10.calculateWidth(), y: 10.calculateHeight(), width: 32.calculateHeight(), height: 32.calculateHeight())
        
        // Set corner radius to make view a circle
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        
        // Set clipsToBounds to true so image is rounded as well
        userImageView.clipsToBounds = true
        
        // Add image to userImageView
        userImageView.image = #imageLiteral(resourceName: "userImage")
        
        // Add userImageView to self
        self.addSubview(userImageView)
        
        // We use 284 here instead of userImageView.frame.maxX to show that you can either snap to another view or you can give the exacty inset from the super view
        // Though views may overlap this way
        userLabel.frame = CGRect(x: 52.calculateWidth(), y: 10.calculateHeight(), width: 284.calculateWidth(), height: 32.calculateHeight())
        userLabel.text = "themisterholliday"
        
        // Set font size and calculate width so font size scales
        // We can use "calculateWidth" for anything not just width or height. Now our font will scale as well!
        userLabel.font = UIFont.systemFont(ofSize: 15.calculateWidth())
        self.addSubview(userLabel)
        
        // It's important to note that we will be able to scale the "ImageView" but the Image will only scale proportionally if you set the correct contentMode
        ellipsesImageView.frame = CGRect(x: 346.calculateWidth(), y: 10.calculateHeight(), width: 14.calculateWidth(), height: 32.calculateHeight())
        ellipsesImageView.image = #imageLiteral(resourceName: "Ellipses")
        
        ellipsesImageView.contentMode = .scaleAspectFill
        self.addSubview(ellipsesImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
