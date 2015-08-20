//
//  CalculateFunctions.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

func calculateCGRect(from from: CGRect, to: CGRect, rate: CGFloat, easing: Easing) -> CGRect {
    return CGRect(
        origin: calculateCGPoint(from: from.origin, to: to.origin, rate: rate, easing: easing),
        size: calculateCGSize(from: from.size, to: to.size, rate: rate, easing: easing)
    )
}

func calculateCGPoint(from from: CGPoint, to: CGPoint, rate: CGFloat, easing: Easing) -> CGPoint {
    return CGPoint(
        x: calculateCGFloat(from: from.x, to: to.x, rate: rate, easing: easing),
        y: calculateCGFloat(from: from.y, to: to.y, rate: rate, easing: easing)
    )
}

func calculateCGSize(from from: CGSize, to: CGSize, rate: CGFloat, easing: Easing) -> CGSize {
    return CGSize(
        width: calculateCGFloat(from: from.width, to: to.width, rate: rate, easing: easing),
        height: calculateCGFloat(from: from.height, to: to.height, rate: rate, easing: easing)
    )
}

func calculateCGFloat(from from: CGFloat, to: CGFloat, rate: CGFloat, easing: Easing) -> CGFloat {
    return easing(t: rate, b: from, c: to-from)
}

struct RGBA {
    var red:CGFloat = 0
    var green:CGFloat = 0
    var blue:CGFloat = 0
    var alpha:CGFloat = 0
    static func fromUIColor(color:UIColor) -> RGBA {
        var rgba = RGBA()
        color.getRed(&rgba.red, green: &rgba.green, blue: &rgba.blue, alpha: &rgba.alpha)
        return rgba
    }
}

func calculateUIColor(from from: UIColor, to: UIColor, rate: CGFloat, easing: Easing) -> UIColor {
    let fromRGBA = RGBA.fromUIColor(from)
    let toRGBA = RGBA.fromUIColor(to)
    return UIColor(
        red: calculateCGFloat(from: fromRGBA.red, to: toRGBA.red, rate: rate, easing: easing),
        green: calculateCGFloat(from: fromRGBA.green, to: toRGBA.green, rate: rate, easing: easing),
        blue: calculateCGFloat(from: fromRGBA.blue, to: toRGBA.blue, rate: rate, easing: easing),
        alpha: calculateCGFloat(from: fromRGBA.alpha, to: toRGBA.alpha, rate: rate, easing: easing)
    )
}
