//
//  TopBarView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class TopBarView: KTResponsiveView {
    var userImageView: KTEqualImageView!
    var userLabel: KTLabel!
    var ellipsesImageView: KTImageView!
    
    override func performLayout() {
        // Set user image frame
        // The user image needs to be a cirle so we use "calculateHeight" for both width and height
        userImageView = KTEqualImageView(topInset: 10, leftInset: 10, height: 32)
        
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
        userLabel = KTLabel(topInset: 10, leftInset: 52, width: 284, height: 32)
        userLabel.text = "themisterholliday"
        
        // Set font size and calculate width so font size scales
        // We can use "calculateWidth" for anything not just width or height. Now our font will scale as well!
        userLabel.font = UIFont.systemFont(ofSize: 15.scaleForScreenWidth())
        self.addSubview(userLabel)
        
        // It's important to note that we will be able to scale the "ImageView" but the Image will only scale proportionally if you set the correct contentMode
        ellipsesImageView = KTImageView(topInset: 10, leftInset: 346, width: 14, height: 32)
        ellipsesImageView.image = #imageLiteral(resourceName: "Ellipses")
        
        ellipsesImageView.contentMode = .scaleAspectFit
        self.addSubview(ellipsesImageView)
    }
}
