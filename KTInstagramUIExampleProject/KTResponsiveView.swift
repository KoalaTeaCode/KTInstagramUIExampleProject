//
//  KTResponsiveView.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/21/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class KTResponsiveView: UIView, PerformLayoutProtocol {
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
