import UIKit

// Protocol to make sure we have common function to use to layout subviews
// This is easier than overriding init() in every class
protocol KTLayoutProtocol {
    init()
    func performLayout()
}

extension KTLayoutProtocol where Self: UIView {
    // Our custom init
    //  - Parameters:
    //      - origin: Point of origin (default is (0,0) like a grid)
    //      - topInset: points from the top of immediate superview or origin when set (default is 0)
    //      - leftInset: points from the left of immediate superview or origin when set (default is 0)
    //      - width: width of view. Will be calculated using .scaleForScreenWidth Extension
    //      - height: height of view. Will be calculated using .scaleForScreenHeight Extension
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat = 0,
         height: CGFloat = 0,
         keepEqual: Bool = false) {
        
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        
        // Calculate width and height
        var cWidth = width.scaleForScreenWidth()
        var cHeight = height.scaleForScreenHeight()
        
        // Here we check if either width or height is 0 which we are assuming means that the variable that isn't 0 should be equal to the variable that has been set
        if keepEqual {
            if width == 0 {
                cWidth = cHeight
            }
            if height == 0 {
                cHeight = cWidth
            }
        }
        
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: cWidth, height: cHeight)
        
        self.init()
        self.frame = newFrame
        self.performLayout()
    }
}

// Everything boiled down to a single extension
extension UIView: KTLayoutProtocol {
    @objc public func performLayout() {}
}

////
////  CustomViews.swift
////  KTInstagramUIExampleProject
////
////  Created by Craig Holliday on 8/15/17.
////  Copyright © 2017 Koala Tea. All rights reserved.
////
//
//import UIKit
//
//// Protocol to make sure we have common function to use to layout subviews
//// This is easier than overriding init() in every class
//protocol KTLayoutProtocol {
//    var width: CGFloat { get set }
//    var height: CGFloat { get set }
//    var frame: CGRect { get set }
//    init(origin: CGPoint, topInset: CGFloat, leftInset: CGFloat, width: CGFloat, height: CGFloat)
//    func performLayout()
//}
//
//// The main responsive view. Our bread and butter going forward
//class KTResponsiveView: UIView, KTLayoutProtocol {
//
//    // Custom width and height variables to quickly return the frame's width and height instead of typing .frame.width every time
//    var width: CGFloat {
//        get { return self.frame.width }
//        set { self.frame.size.width = newValue }
//    }
//    var height: CGFloat {
//        get { return self.frame.height }
//        set { self.frame.size.height = newValue }
//    }
//
//    // We also have custom width/height variables so we can set intrinsice content size
//    // This only helps when using StackViews (We'll cover that later)
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: width, height: height)
//    }
//
//    // Our custom init
//    //  - Parameters:
//    //      - origin: Point of origin (default is (0,0) like a grid)
//    //      - topInset: points from the top of immediate superview or origin when set (default is 0)
//    //      - leftInset: points from the left of immediate superview or origin when set (default is 0)
//    //      - width: width of view. Will be calculated using .scaleForScreenWidth Extension
//    //      - height: height of view. Will be calculated using .scaleForScreenHeight Extension
//    required init(origin: CGPoint = CGPoint(x: 0,y: 0),
//         topInset: CGFloat = 0,
//         leftInset: CGFloat = 0,
//         width: CGFloat,
//         height: CGFloat) {
//
//        // Calculate position of new frame
//        let cx = origin.x + leftInset.scaleForScreenWidth()
//        let cy = origin.y + topInset.scaleForScreenHeight()
//        // Create new frame
//        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
//
//        super.init(frame: newFrame)
//        self.performLayout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // This function is where we perform all our layout
//    func performLayout() {}
//}
//
//class KTButton: UIButton, KTLayoutProtocol {
//    var width: CGFloat {
//        get { return self.frame.width }
//        set { self.frame.size.width = newValue }
//    }
//    var height: CGFloat {
//        get { return self.frame.height }
//        set { self.frame.size.height = newValue }
//    }
//
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: width, height: height)
//    }
//
//    required init(origin: CGPoint = CGPoint(x: 0,y: 0),
//         topInset: CGFloat = 0,
//         leftInset: CGFloat = 0,
//         width: CGFloat,
//         height: CGFloat) {
//        // Calculate position of new frame
//        let cx = origin.x + leftInset.scaleForScreenWidth()
//        let cy = origin.y + topInset.scaleForScreenHeight()
//        // Create new frame
//        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
//
//        super.init(frame: newFrame)
//        self.performLayout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // This function is where we perform all our layout
//    func performLayout() {}
//}
//
//class KTLabel: UILabel, KTLayoutProtocol {
//    var width: CGFloat {
//        get { return self.frame.width }
//        set { self.frame.size.width = newValue }
//    }
//    var height: CGFloat {
//        get { return self.frame.height }
//        set { self.frame.size.height = newValue }
//    }
//
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: width, height: height)
//    }
//
//    required init(origin: CGPoint = CGPoint(x: 0,y: 0),
//         topInset: CGFloat = 0,
//         leftInset: CGFloat = 0,
//         width: CGFloat,
//         height: CGFloat) {
//        // Calculate position of new frame
//        let cx = origin.x + leftInset.scaleForScreenWidth()
//        let cy = origin.y + topInset.scaleForScreenHeight()
//        // Create new frame
//        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
//
//        super.init(frame: newFrame)
//        self.performLayout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // This function is where we perform all our layout
//    func performLayout() {}
//}
//
//class KTImageView: UIImageView, KTLayoutProtocol {
//    var width: CGFloat {
//        get { return self.frame.width }
//        set { self.frame.size.width = newValue }
//    }
//    var height: CGFloat {
//        get { return self.frame.height }
//        set { self.frame.size.height = newValue }
//    }
//
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: width, height: height)
//    }
//
//    required init(origin: CGPoint = CGPoint(x: 0, y: 0),
//         topInset: CGFloat = 0,
//         leftInset: CGFloat = 0,
//         width: CGFloat,
//         height: CGFloat) {
//        // Calculate position of new frame
//        let cx = origin.x + leftInset.scaleForScreenWidth()
//        let cy = origin.y + topInset.scaleForScreenHeight()
//        // Create new frame
//        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
//
//        super.init(frame: newFrame)
//        self.performLayout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // This function is where we perform all our layout
//    func performLayout() {}
//}
//
//// @TODO: TBH, This is kind of hacked together
//class KTEqualImageView: UIImageView, KTLayoutProtocol {
//    var width: CGFloat {
//        get { return self.frame.width }
//        set { self.frame.size.width = newValue }
//    }
//    var height: CGFloat {
//        get { return self.frame.height }
//        set { self.frame.size.height = newValue }
//    }
//
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: width, height: height)
//    }
//
//    // Our custom init
//    //  - Parameters:
//    //      - origin: Point of origin (default is (0,0) like a grid)
//    //      - topInset: points from the top of immediate superview or origin when set (default is 0)
//    //      - leftInset: points from the left of immediate superview or origin when set (default is 0)
//    //      - width: width of view. Will be calculated using .scaleForScreenWidth Extension (default is 0)
//    //      - height: height of view. Will be calculated using .scaleForScreenHeight Extension (default is 0)
//    required init(origin: CGPoint = CGPoint(x: 0,y: 0),
//         topInset: CGFloat = 0,
//         leftInset: CGFloat = 0,
//         width: CGFloat = 0,
//         height: CGFloat = 0) {
//        // Calculate position of new frame
//        let cx = origin.x + leftInset.scaleForScreenWidth()
//        let cy = origin.y + topInset.scaleForScreenHeight()
//        // Create new frame
//        var cWidth = width.scaleForScreenWidth()
//        var cHeight = height.scaleForScreenHeight()
//
//        // Here we check if either width or height is 0 which we are assuming means that the variable that isn't 0 should be equal to the variable that has been set
//        if width == 0 {
//            cWidth = cHeight
//        }
//        if height == 0 {
//            cHeight = cWidth
//        }
//        let newFrame = CGRect(x: cx, y: cy, width: cWidth, height: cHeight)
//
//        super.init(frame: newFrame)
//        self.performLayout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // This function is where we perform all our layout
//    func performLayout() {}
//}

