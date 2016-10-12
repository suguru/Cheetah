//
//  CheetahViewProperties.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

class CheetahViewSizeProperty: CheetahCGSizeProperty {
    
    init(view: UIView?, size: CGSize, relative: Bool = false) {
        super.init()
        self.to = size
        self.view = view
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = view.bounds.size
    }
    
    override func update() {
        guard let view = view else {
            return
        }
        view.bounds = CGRect(origin: CGPoint.zero, size: calculateCGSize(from: from, to: toCalc))
    }
    
}

class CheetahViewFrameProperty: CheetahCGRectProperty {
    
    init(view: UIView?, frame: CGRect, relative: Bool = false) {
        super.init()
        self.view = view
        self.to = frame
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = view.frame
    }
    
    override func update() {
        guard let view = view else {
            return
        }
        view.frame = calculateCGRect(from: from, to: toCalc)
    }
    
}

class CheetahViewAlphaProperty: CheetahCGFloatProperty {
    
    init(view: UIView?, alpha: CGFloat, relative: Bool = false) {
        super.init()
        self.view = view
        self.to = alpha
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = view.alpha
    }
    
    override func update() {
        guard let view = view else {
            return
        }
        view.alpha = calculateCGFloat(from: from, to: toCalc)
    }
}

class CheetahViewBackgroundColorProperty: CheetahUIColorProperty {
    
    init(view: UIView?, color: UIColor, relative: Bool = false) {
        super.init()
        self.view = view
        self.to = color
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        guard let view = view else {
            return
        }
        from = view.backgroundColor
    }
    
    override func update() {
        guard let view = view else {
            return
        }
        view.backgroundColor = calculateUIColor(from: from, to: toCalc)
    }
    
}
