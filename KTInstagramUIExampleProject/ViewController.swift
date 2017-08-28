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

//        postView = PostView(width: 375, height: 960)
//        self.view.addSubview(postView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
