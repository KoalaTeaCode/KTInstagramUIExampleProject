//
//  PostView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class PostView: UIView {

    var topBarView: TopBarView!
    var postImageView: UIImageView!
    var buttonView: ButtonView!
    var commentsView: CommentsView!
    
    override func performLayout() {
        topBarView = TopBarView(width: 375, height: 54)
        self.addSubview(topBarView)

        postImageView = UIImageView(origin: topBarView.bottomLeftPoint(), width: 375, keepEqual: true)
        postImageView.image = #imageLiteral(resourceName: "postImage")
        self.addSubview(postImageView)
        
        buttonView = ButtonView(origin: postImageView.bottomLeftPoint(), width: 375, height: 48)
        self.addSubview(buttonView)
        
        commentsView = CommentsView(origin: buttonView.bottomLeftPoint(), width: 375, height: 0)
        self.addSubview(commentsView)
    }
}
