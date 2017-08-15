//
//  CommentsView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class CommentsView: UIView {
    
    // Likes
    var likeLabel: UILabel!
    
    // Description
    var descriptionLabel: UILabel!
    var moreLabel: UILabel!
    
    // View All Comments
    var viewAllCommentsLabel: UILabel!
    
    // Time View
    var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let labelsWidth = self.frame.width - (16.calculateWidth() * 2)
        
        likeLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: 0, width: labelsWidth, height: 18.calculateHeight()))
        let likesCount = 287
        let likesString = "likes"
        
        likeLabel.font = UIFont.boldSystemFont(ofSize: 15.calculateHeight())
        likeLabel.text = String(likesCount) + " " + likesString
        self.addSubview(likeLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: likeLabel.frame.maxY, width: labelsWidth, height: 42.calculateHeight()))
        let username = "themisterholliday"
        let description = "Hey this is an awesome description"
        
        descriptionLabel.numberOfLines = 0
        
        let fullMutableString = NSMutableAttributedString()
        let usernameMutableString = NSMutableAttributedString(
            string: username,
            attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15.calculateHeight())])
        let spaceString = NSMutableAttributedString(string: " ")
        let descMutableString = NSMutableAttributedString(
            string: description,
            attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15.calculateHeight())])
        fullMutableString.append(usernameMutableString)
        fullMutableString.append(spaceString)
        fullMutableString.append(descMutableString)
        
        descriptionLabel.attributedText = fullMutableString
        self.addSubview(descriptionLabel)
        
        viewAllCommentsLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: descriptionLabel.frame.maxY, width: labelsWidth, height: 20.calculateHeight()))
        viewAllCommentsLabel.text = "View all 5 comments"
        viewAllCommentsLabel.font = UIFont.systemFont(ofSize: 14.calculateHeight())
        self.addSubview(viewAllCommentsLabel)
        
        timeLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: viewAllCommentsLabel.frame.maxY, width: labelsWidth, height: 24.calculateHeight()))
        timeLabel.text = "3 HOURS AGO"
        timeLabel.font = UIFont.systemFont(ofSize: 11.calculateHeight())
        self.addSubview(timeLabel)
        
        var height: CGFloat = 0
        for view in subviews {
            height += view.frame.height
        }
        self.frame.size.height = height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
