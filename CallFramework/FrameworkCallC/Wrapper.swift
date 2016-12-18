//
//  Wrapper.swift
//  FrameworkCallC
//
//  Created by ethan on 2016/12/16.
//  Copyright © 2016年 ethan. All rights reserved.
//

import UIKit
import LibWorld

open class Wrapper {
    public init() {
        
    }
    
    open func callHello() {
        let h = Hello()
        h.hello();
    }
    
    open func callCWorld() {
        LibWorld.world()
    }
    
    open func callObjCWorld() {
        let objcWorld = LibWorld.ObjCWorld()
        objcWorld.world()
    }
    
}
