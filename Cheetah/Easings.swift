//
//  Easings.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

public typealias Easing = (_ t:CGFloat, _ b:CGFloat, _ c:CGFloat) -> CGFloat

private let F_PI = CGFloat(M_PI)

// Calculate cubic bezier curve
public struct Easings {
    
    public static let linear:Easing = { (t:CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
        return c*t+b
    }
    
    // return easing with cubic bezier curve
    public static func cubicBezier(_ c1x:CGFloat, _ c1y:CGFloat, _ c2x:CGFloat, _ c2y:CGFloat) -> Easing {
        let bezier = UnitBezier(p1x: c1x, p1y: c1y, p2x: c2x, p2y: c2y)
        return { (t: CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
            let y = bezier.solve(t)
            return c*y+b
        }
    }

    // Easing curves are from https://github.com/ai/easings.net/
    public static let easeInSine:Easing = Easings.cubicBezier(0.47,0,0.745,0.715)
    public static let easeOutSine:Easing = Easings.cubicBezier(0.39,0.575,0.565, 1)
    public static let easeInOutSine:Easing = Easings.cubicBezier(0.455,0.03,0.515,0.955)
    public static let easeInQuad:Easing = Easings.cubicBezier(0.55, 0.085, 0.68, 0.53)
    public static let easeOutQuad:Easing = Easings.cubicBezier(0.25, 0.46, 0.45, 0.94)
    public static let easeInOutQuad:Easing = Easings.cubicBezier(0.455, 0.03, 0.515, 0.955)
    public static let easeInCubic:Easing = Easings.cubicBezier(0.55, 0.055, 0.675, 0.19)
    public static let easeOutCubic:Easing = Easings.cubicBezier(0.215, 0.61, 0.355, 1)
    public static let easeInOutCubic:Easing = Easings.cubicBezier(0.645, 0.045, 0.355, 1)
    public static let easeInQuart:Easing = Easings.cubicBezier(0.895, 0.03, 0.685, 0.22)
    public static let easeOutQuart:Easing = Easings.cubicBezier(0.165, 0.84, 0.44, 1)
    public static let easeInOutQuart:Easing = Easings.cubicBezier(0.77, 0, 0.175, 1)
    public static let easeInQuint:Easing = Easings.cubicBezier(0.755, 0.05, 0.855, 0.06)
    public static let easeOutQuint:Easing = Easings.cubicBezier(0.23, 1, 0.32, 1)
    public static let easeInOutQuint:Easing = Easings.cubicBezier(0.86,0,0.07,1)
    public static let easeInExpo:Easing = Easings.cubicBezier(0.95, 0.05, 0.795, 0.035)
    public static let easeOutExpo:Easing = Easings.cubicBezier(0.19, 1, 0.22, 1)
    public static let easeInOutExpo:Easing = Easings.cubicBezier(1, 0, 0, 1)
    public static let easeInCirc:Easing = Easings.cubicBezier(0.6, 0.04, 0.98, 0.335)
    public static let easeOutCirc:Easing = Easings.cubicBezier(0.075, 0.82, 0.165, 1)
    public static let easeInOutCirc:Easing = Easings.cubicBezier(0.785, 0.135, 0.15, 0.86)
    public static let easeInBack:Easing = Easings.cubicBezier(0.6, -0.28, 0.735, 0.045)
    public static let easeOutBack:Easing = Easings.cubicBezier(0.175, 0.885, 0.32, 1.275)
    public static let easeInOutBack:Easing = Easings.cubicBezier(0.68, -0.55, 0.265, 1.55)
    
    // Easing equations from robert penner's functions
    // http://robertpenner.com/easing/
    public static let easeInElastic:Easing = { (t:CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
        if t == 0 {
            return b
        }
        if t == 1 {
            return b + c
        }
        var p: CGFloat = 0.3
        var a = c;
        var s = p / 4
        var t = t - 1
        return -(a * pow(2, 10 * t) * sin((t - s) * (2 * F_PI) / p)) + b;
    }
    public static let easeOutElastic:Easing = { (t:CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
        if t == 0 {
            return b
        }
        if t == 1 {
            return b + c
        }
        var p: CGFloat = 0.3
        var s = p / 4
        var a = c
        return  a * pow(2, -10 * t) * sin((t - s) * (2 * F_PI) / p) + c + b
    }
    public static let easeInOutElastic:Easing = { (t:CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
        if t == 0 {
            return b
        }
        if t == 1 {
            return b + c
        }
        var t = t * 2
        var p: CGFloat = 0.3 * 1.5
        var a = c;
        var s = p / 4
        if t < 1 {
            t  = t - 1
            return -0.5 * (a * pow(2, 10 * t) * sin((t - s) * (2 * F_PI) / p)) + b
        } else {
            t =  t - 1
            return a * pow(2, -10 * t) * sin((t - s) * (2 * F_PI) / p) * 0.5 + c + b
        }
    }
    public static let easeInBounce:Easing = { (t:CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
        return c - Easings.easeOutBounce(1-t, 0, c) + b
    }
    public static let easeOutBounce:Easing = { (t:CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
        if t < 1/2.75 {
            return c * (7.5625 * t * t) + b;
        } else if t < 2/2.75 {
            let t = t - 1.5/2.75
            return c * (7.5625 * t * t + 0.75) + b;
        } else if (t < (2.5/2.75)) {
            let t = t - 2.25 / 2.75
            return c * (7.5625 * t * t + 0.9375) + b;
        } else {
            let t = t - 2.625 / 2.75
            return c * (7.5625 * t * t + 0.984375) + b;
        }
    }
    public static let easeInOutBounce:Easing = { (t:CGFloat, b:CGFloat, c:CGFloat) -> CGFloat in
        if t < 0.5 {
            return Easings.easeInBounce(t * 2, 0, c) * 0.5 + b;
        } else {
            return Easings.easeOutBounce(t * 2 - 1, 0, c) * 0.5 + c * 0.5 + b
        }
    }
}
