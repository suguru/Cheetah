//
//  CheetahGroup.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/20.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

// CheetahGroup
class CheetahGroup {
    
    weak var view: UIView?
    var properties = [CheetahProperty]()
    var anchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)
    var fromTransform: CATransform3D = CATransform3DIdentity
    var elapsed: CFTimeInterval = 0
    var delay: CFTimeInterval = 0
    var duration: CFTimeInterval = 1.0
    
    init(view: UIView?) {
        self.view = view
    }
    
    func prepare() {
        elapsed = 0
        for prop in properties {
            prop.prepare()
            prop.calc()
        }
    }
    
    func proceed(_ dt: CFTimeInterval) -> Bool {
        elapsed += dt
        if elapsed < delay {
            return false
        }
        if properties.count == 0 {
            return true
        }
        // proceed each item properties
        var done = true
        var transform = fromTransform
        for prop in properties {
            // mark false if any of items are undone
            if !prop.proceed(dt) {
                done = false
            }
            if !CATransform3DIsIdentity(prop.transform) {
                transform = CATransform3DConcat(transform, prop.transform)
            }
        }
        view?.layer.transform = transform
        return done
    }
    
}

