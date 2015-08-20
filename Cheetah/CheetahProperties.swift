//
//  CheetahProperties.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

// CheetahProperty
public class CheetahProperty {
    
    weak var view: UIView!
    weak var group: CheetahGroup!
    
    var duration: CFTimeInterval = 1
    var delay: CFTimeInterval = 0
    var elapsed: CFTimeInterval = 0
    var current: CGFloat = 0
    var easing: Easing = Easings.linear
    var completion: (() -> Void)?
    var relative: Bool = false
    var transform: CATransform3D = CATransform3DIdentity
    
    func proceed(dt: CFTimeInterval) -> Bool {
        let end = delay + duration
        if elapsed >= end {
            return true
        }
        elapsed = min(elapsed + dt, end)
        if elapsed >= delay {
            current = CGFloat((elapsed - delay) / duration)
            update()
        }
        if let completion = completion where elapsed >= end {
            completion()
        }
        return elapsed >= end
    }
    
    func prepare() {
        // reset values
        elapsed = 0
        current = 0
    }
    
    func calc() {
    }
    
    func update() {
    }
}

public class CheetahCGFloatProperty: CheetahProperty {
    var from: CGFloat = 0
    var to: CGFloat = 0
    var toCalc: CGFloat = 0
    override func calc() {
        if relative {
            toCalc = from + to
        } else {
            toCalc = to
        }
    }
}

public class CheetahCGSizeProperty: CheetahProperty {
    var from: CGSize = CGSizeZero
    var to: CGSize = CGSizeZero
    var toCalc: CGSize = CGSizeZero
    override func calc() {
        if relative {
            toCalc = CGSize(width: from.width+to.width, height: from.height+to.height)
        } else {
            toCalc = to
        }
    }
}

public class CheetahCGPointProperty: CheetahProperty {
    var from: CGPoint = CGPointZero
    var to: CGPoint = CGPointZero
    var toCalc: CGPoint = CGPointZero
    override func calc() {
        if relative {
            toCalc = CGPoint(x: from.x+to.x, y: from.y+to.y)
        } else {
            toCalc = to
        }
    }
}

public class CheetahCGRectProperty: CheetahProperty {
    var from: CGRect = CGRectZero
    var to: CGRect = CGRectZero
    var toCalc: CGRect = CGRectZero
    override func calc() {
        if relative {
            toCalc = CGRect(x: from.origin.x+to.origin.x, y: from.origin.y+to.origin.y, width: from.width+to.width, height: from.height+to.height)
        } else {
            toCalc = to
        }
    }
}

public class CheetahUIColorProperty: CheetahProperty {
    var from: UIColor!
    var to: UIColor!
    var toCalc: UIColor!
    override func calc() {
        if relative {
            let fromRGBA = RGBA.fromUIColor(from)
            let toRGBA = RGBA.fromUIColor(to)
            toCalc = UIColor(red: fromRGBA.red+toRGBA.red, green: fromRGBA.green+toRGBA.green, blue: fromRGBA.blue+toRGBA.blue, alpha: fromRGBA.alpha+toRGBA.alpha)
        } else {
            toCalc = to
        }
    }
}
