//
//  CheetahViewProperties.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

class CheetahViewSizeProperty: CheetahCGSizeProperty {
    
    init(view: UIView!, size: CGSize, relative: Bool = false) {
        super.init()
        self.to = size
        self.view = view
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        from = view.bounds.size
    }
    
    override func update() {
        view.bounds = CGRect(origin: CGPointZero, size: calculateCGSize(from: from, to: toCalc))
    }
    
}

class CheetahViewFrameProperty: CheetahCGRectProperty {
    
    init(view: UIView!, frame: CGRect, relative: Bool = false) {
        super.init()
        self.view = view
        self.to = frame
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        from = view.frame
    }
    
    override func update() {
        view.frame = calculateCGRect(from: from, to: toCalc)
    }
    
}

class CheetahViewAlphaProperty: CheetahCGFloatProperty {
    
    init(view: UIView!, alpha: CGFloat, relative: Bool = false) {
        super.init()
        self.view = view
        self.to = alpha
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        from = view.alpha
    }
    
    override func update() {
        view.alpha = calculateCGFloat(from: from, to: toCalc)
    }
}

class CheetahViewBackgroundColorProperty: CheetahUIColorProperty {
    
    init(view: UIView!, color: UIColor, relative: Bool = false) {
        super.init()
        self.view = view
        self.to = color
        self.relative = relative
    }
    
    override func prepare() {
        super.prepare()
        from = view.backgroundColor
    }
    
    override func update() {
        view.backgroundColor = calculateUIColor(from: from, to: toCalc)
    }
    
}