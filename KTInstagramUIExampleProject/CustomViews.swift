//
//  CustomViews.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/15/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

// These are custom views for use in Stack Views. When using frame to set width and height of a view, the intrinsic content size does not get updated correctly to be used in a Stack View.

class KTView: UIView {
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
}

class KTLabel: KTView {}
