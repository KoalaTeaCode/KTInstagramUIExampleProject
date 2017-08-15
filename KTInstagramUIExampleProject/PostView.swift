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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topBarView = TopBarView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 54.calculateHeight()))
        self.addSubview(topBarView)
        
        postImageView = UIImageView(frame: CGRect(x: 0, y: topBarView.frame.maxY, width: self.frame.width, height: self.frame.width))
        postImageView.image = #imageLiteral(resourceName: "postImage")
        self.addSubview(postImageView)
        
        buttonView = ButtonView(frame: CGRect(x: 0, y: postImageView.frame.maxY, width: self.frame.width, height: 48.calculateHeight()))
        self.addSubview(buttonView)
        
        commentsView = CommentsView(frame: CGRect(x: 0, y: buttonView.frame.maxY, width: self.frame.width, height: 0))
        self.addSubview(commentsView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
