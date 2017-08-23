//
//  Extensions.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

let iphone7Height: CGFloat = 667.0
let iphone7Width: CGFloat = 375.0

extension Int {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension Double {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension CGFloat {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / self
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / self
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension Float {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension UIView {
    func topRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.minY)
    }
    
    func topMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.minY)
    }
    
    func topLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    func bottomRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.maxY)
    }
    
    func bottomMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.maxY)
    }
    
    func bottomLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.maxY)
    }
    
    func leftMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.midY)
    }
    
    func rightMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.midY)
    }
}

