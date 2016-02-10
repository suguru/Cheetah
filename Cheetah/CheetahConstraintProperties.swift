//
//  CheetahConstraintProperties.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/09/24.
//  Copyright © 2015年 Suguru Namura. All rights reserved.
//

import UIKit

class CheetahConstraintProperty: CheetahCGFloatProperty {
    
    var last: CGFloat = 0
    weak var constraint: NSLayoutConstraint?
    
    init(view: UIView?, constraint: NSLayoutConstraint?, constant: CGFloat, relative: Bool = false) {
        super.init()
        self.view = view
        self.constraint = constraint
        self.relative = relative
        to = constant
    }
    
    override func prepare() {
        super.prepare()
        guard let constraint = constraint else {
            return
        }
        from = constraint.constant
    }
    
    override func update() {
        let curr = calculateCGFloat(from: from, to: toCalc)
        guard let constraint = constraint else {
            return
        }
        constraint.constant = curr
    }
    
}
