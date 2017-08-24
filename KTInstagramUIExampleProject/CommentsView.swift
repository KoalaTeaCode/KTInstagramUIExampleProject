//
//  CommentsView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class CommentsView: KTResponsiveView {
    var likeLabel: KTLabel!
    var descriptionLabel: KTLabel!
    var moreLabel: KTLabel!
    var viewAllCommentsLabel: KTLabel!
    var timeLabel: KTLabel!

    override func performLayout() {
        let labelsWidth: CGFloat = 375 - (16 * 2)
        
        likeLabel = KTLabel(leftInset: 16, width: labelsWidth, height: 18)
        let likesCount = 287
        let likesString = "likes"
        
        likeLabel.font = UIFont.boldSystemFont(ofSize: 15.scaleForScreenWidth())
        likeLabel.text = String(likesCount) + " " + likesString
        self.addSubview(likeLabel)
        
        descriptionLabel = KTLabel(origin: likeLabel.bottomLeftPoint(), width: labelsWidth, height: 42)
        let username = "themisterholliday"
        let description = "Hey this is an awesome description"
        
        descriptionLabel.numberOfLines = 0
        
        let fullMutableString = NSMutableAttributedString()
        let usernameMutableString = NSMutableAttributedString(
            string: username,
            attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 15.scaleForScreenWidth())])
        let spaceString = NSMutableAttributedString(string: " ")
        let descMutableString = NSMutableAttributedString(
            string: description,
            attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.scaleForScreenWidth())])
        fullMutableString.append(usernameMutableString)
        fullMutableString.append(spaceString)
        fullMutableString.append(descMutableString)
        
        descriptionLabel.attributedText = fullMutableString
        self.addSubview(descriptionLabel)
        
        viewAllCommentsLabel = KTLabel(origin: descriptionLabel.bottomLeftPoint(), width: labelsWidth, height: 20)
        viewAllCommentsLabel.text = "View all 5 comments"
        viewAllCommentsLabel.font = UIFont.systemFont(ofSize: 14.scaleForScreenWidth())
        self.addSubview(viewAllCommentsLabel)
        
        timeLabel = KTLabel(origin: viewAllCommentsLabel.bottomLeftPoint(), width: labelsWidth, height: 24)
        timeLabel.text = "3 HOURS AGO"
        timeLabel.font = UIFont.systemFont(ofSize: 11.scaleForScreenWidth())
        self.addSubview(timeLabel)
        
        var height: CGFloat = 0
        for view in subviews {
            height += view.frame.height
        }
        self.frame.size.height = height
    }
}
