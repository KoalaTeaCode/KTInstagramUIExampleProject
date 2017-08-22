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
    var postImageView: KTEqualImageView!
    var buttonView: ButtonView!
    var commentsView: CommentsView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topBarView = TopBarView(width: 375, height: 54)
        self.addSubview(topBarView)
        
        postImageView = KTEqualImageView(origin: topBarView.bottomLeftPoint(), width: 375)
        postImageView.image = #imageLiteral(resourceName: "postImage")
        self.addSubview(postImageView)

        buttonView = ButtonView(origin: postImageView.bottomLeftPoint(), width: 375, height: 48)
        self.addSubview(buttonView)
        
        commentsView = CommentsView(origin: buttonView.bottomLeftPoint(), width: 375, height: 0)
        self.addSubview(commentsView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
