//
//  ViewController.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var postView: PostView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postView = PostView(width: 375, height: 960)
        self.view.addSubview(postView)
        
//        let ktView = KTResponsiveView(width: 250, height: 250, topInset: 10, leftInset: 10)
//        ktView.backgroundColor = .red
//        self.view.addSubview(ktView)
//
//        let _1 = KTResponsiveView(origin: ktView.topLeftPoint(), width: 50, height: 50)
//        let _2 = KTResponsiveView(origin: ktView.topMidPoint(), width: 50, height: 50)
//        let _3 = KTResponsiveView(origin: ktView.topRightPoint(), width: 50, height: 50)
//        let _4 = KTResponsiveView(origin: ktView.leftMidPoint(), width: 50, height: 50)
//        let _5 = KTResponsiveView(origin: ktView.rightMidPoint(), width: 50, height: 50)
//        let _6 = KTResponsiveView(origin: ktView.bottomLeftPoint(), width: 50, height: 50)
//        let _7 = KTResponsiveView(origin: ktView.bottomMidPoint(), width: 50, height: 50)
//        let _8 = KTResponsiveView(origin: ktView.bottomRightPoint(), width: 50, height: 50)
//
//        _1.backgroundColor = .yellow
//        _2.backgroundColor = .yellow
//        _3.backgroundColor = .yellow
//        _4.backgroundColor = .yellow
//        _5.backgroundColor = .yellow
//        _6.backgroundColor = .yellow
//        _7.backgroundColor = .yellow
//        _8.backgroundColor = .yellow
//
//        self.view.addSubview(_1)
//        self.view.addSubview(_2)
//        self.view.addSubview(_3)
//        self.view.addSubview(_4)
//        self.view.addSubview(_5)
//        self.view.addSubview(_6)
//        self.view.addSubview(_7)
//        self.view.addSubview(_8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
