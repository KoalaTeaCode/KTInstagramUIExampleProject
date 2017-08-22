//
//  CustomViews.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/15/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

// These are custom views for use in Stack Views. When using frame to set width and height of a view, the intrinsic content size does not get updated correctly to be used in a Stack View.

protocol PerformLayoutProtocol {
    func performLayout()
}

class KTButton: UIButton, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat,
         height: CGFloat) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performLayout() {}
}

class KTLabel: UILabel, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat,
         height: CGFloat) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performLayout() {}
}

class KTImageView: UIImageView, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat,
         height: CGFloat) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performLayout() {}
}

// @TODO: This is kind of hacked together
class KTEqualImageView: UIImageView, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat = 0,
         height: CGFloat = 0) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        var cWidth = width.scaleForScreenWidth()
        var cHeight = height.scaleForScreenHeight()
        if width == 0 {
            cWidth = cHeight
        }
        if height == 0 {
            cHeight = cWidth
        }
        let newFrame = CGRect(x: cx, y: cy, width: cWidth, height: cHeight)
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performLayout() {}
}

