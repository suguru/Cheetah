//
//  CheetahLabelProperties.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/22.
//  Copyright © 2015年 Suguru Namura. All rights reserved.
//

import UIKit

class CheetahTextColorProperty: CheetahUIColorProperty {
    
    init(view: UIView!, textColor: UIColor, relative: Bool = false) {
        super.init()
        self.view = view
        self.to = textColor
        self.relative = relative
    }
    
    override func prepare() {
        guard let text = view as? UILabel else {
            return
        }
        super.prepare()
        from = text.textColor
    }
    
    override func update() {
        guard let text = view as? UILabel else {
            return
        }
        text.textColor = calculateUIColor(from: from, to: toCalc)
    }
    
}
