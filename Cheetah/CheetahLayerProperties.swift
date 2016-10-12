//
//  CheetahLayerProperties.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/20.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

class CheetahLayerPositionProperty: CheetahCGPointProperty {
    
    init(view: UIView?, position: CGPoint, relative: Bool = false) {
        super.init()
        self.view = view
        self.relative = relative
        to = position
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = view.layer.position
    }
    
    override func update() {
        guard let view = view else {
            return
        }
        view.layer.position = calculateCGPoint(from: from, to: toCalc)
    }

}

class CheetahLayerRotationProperty: CheetahCGFloatProperty {
    
    var last: CGFloat = 0
    
    init(view: UIView?, rotation: CGFloat, relative: Bool = false) {
        super.init()
        self.view = view
        self.relative = relative
        to = rotation
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = atan2(view.layer.transform.m12, view.layer.transform.m11)
    }
    
    override func update() {
        let curr = calculateCGFloat(from: from, to: toCalc)
        transform = CATransform3DMakeRotation(curr, 0, 0, 1)
    }
    
}

class CheetahLayerScaleProperty: CheetahCGPointProperty {
    
    var last: CGPoint = CGPoint.zero
    
    init(view: UIView?, scale: CGPoint) {
        super.init()
        self.view = view
        to = scale
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        let t = view.layer.transform
        from.x = sqrt((t.m11 * t.m11) + (t.m12 * t.m12) + (t.m13 * t.m13))
        from.y = sqrt((t.m21 * t.m21) + (t.m22 * t.m22) + (t.m23 * t.m23))
    }
    
    override func update() {
        let curr = calculateCGPoint(from: from, to: toCalc)
        transform = CATransform3DMakeScale(curr.x, curr.y, 1)
    }
    
}

class CheetahLayerBorderWidthProperty: CheetahCGFloatProperty {
    
    init(view: UIView?, borderWidth: CGFloat) {
        super.init()
        self.view = view
        to = borderWidth
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = view.layer.borderWidth
    }
    
    override func update() {
        guard let view = view else {
            return
        }
        view.layer.borderWidth = calculateCGFloat(from: from, to: toCalc)
    }
    
}

class CheetahLayerCornerRadiusProperty: CheetahCGFloatProperty {
    
    init(view: UIView?, cornerRadius: CGFloat) {
        super.init()
        self.view = view
        to = cornerRadius
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = view.layer.cornerRadius
    }
    
    override func update() {
        guard let view = view else {
            return
        }
        view.layer.cornerRadius = calculateCGFloat(from: from, to: toCalc)
    }
    
}

class CheetahLayerBorderColorProperty: CheetahUIColorProperty {
    
    init(view: UIView?, borderColor: UIColor) {
        super.init()
        self.view = view
        self.to = borderColor
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        if let borderColor = view.layer.borderColor {
            from = UIColor(cgColor: borderColor)
        } else {
            from = UIColor.black
        }
    }
    
    override func update() {
        let color = calculateUIColor(from: from, to: toCalc)
        guard let view = view else {
            return
        }
        view.layer.borderColor = color.cgColor
    }
    
}
