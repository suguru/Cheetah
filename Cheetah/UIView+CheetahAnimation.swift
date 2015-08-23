//
//  UIView+CheetahAnimation.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

var cheetahAssociationKey = "cheetahAssociation"

public extension UIView {
    
    public var cheetah: Cheetah {
        get {
            if let instance = objc_getAssociatedObject(self, &cheetahAssociationKey) as? Cheetah {
                return instance
            }
            let instance = Cheetah(view: self)
            objc_setAssociatedObject(self, &cheetahAssociationKey, instance, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return instance
        }
    }

}
