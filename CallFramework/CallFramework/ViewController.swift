//
//  ViewController.swift
//  CallFramework
//
//  Created by ethan on 2016/12/16.
//  Copyright © 2016年 ethan. All rights reserved.
//

import UIKit
import FrameworkCallC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let wrapper = Wrapper()
        wrapper.callHello();
        wrapper.callCWorld()
        wrapper.callObjCWorld()
        
        let hello = Hello()
        hello.hello()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

