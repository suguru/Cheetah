//
//  CheetahLayerProperties.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/20.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

class CheetahLayerPositionProperty: CheetahCGPointProperty {
    
    init(view: UIView!, position: CGPoint, relative: Bool = false) {
        super.init()
        self.view = view
        self.relative = relative
        to = position
    }
    
    override func prepare() {
        super.prepare()
        from = view.layer.position
    }
    
    override func update() {
        view.layer.position = calculateCGPoint(from: from, to: toCalc, rate: current, easing: easing)
    }

}

class CheetahLayerRotationProperty: CheetahCGFloatProperty {
    
    var last: CGFloat = 0
    
    init(view: UIView!, rotation: CGFloat, relative: Bool = false) {
        super.init()
        self.view = view
        self.relative = relative
        to = rotation
    }
    
    override func prepare() {
        super.prepare()
        from = atan2(view.layer.transform.m12, view.layer.transform.m11)
    }
    
    override func update() {
        let curr = calculateCGFloat(from: from, to: toCalc, rate: current, easing: easing)
        transform = CATransform3DMakeRotation(curr, 0, 0, 1)
    }
    
}

class CheetahLayerScaleProperty: CheetahCGPointProperty {
    
    var last: CGPoint = CGPointZero
    
    init(view: UIView!, scale: CGPoint) {
        super.init()
        self.view = view
        to = scale
    }
    
    override func prepare() {
        super.prepare()
        let t = view.layer.transform
        from.x = sqrt((t.m11 * t.m11) + (t.m12 * t.m12) + (t.m13 * t.m13))
        from.y = sqrt((t.m21 * t.m21) + (t.m22 * t.m22) + (t.m23 * t.m23))
    }
    
    override func update() {
        let curr = calculateCGPoint(from: from, to: toCalc, rate: current, easing: easing)
        transform = CATransform3DMakeScale(curr.x, curr.y, 1)
    }
    
}
