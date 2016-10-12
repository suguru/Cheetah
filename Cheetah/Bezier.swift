//
//  Bezier.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/20.
//  Copyright © 2015年 Suguru Namura.
//

// This implementation is based on WebCore Bezier implmentation
// http://opensource.apple.com/source/WebCore/WebCore-955.66/platform/graphics/UnitBezier.h
//

private let epsilon: CGFloat = 1.0 / 1000

struct UnitBezier {
    var ax: CGFloat
    var ay: CGFloat
    var bx: CGFloat
    var by: CGFloat
    var cx: CGFloat
    var cy: CGFloat
    init(p1x: CGFloat, p1y: CGFloat, p2x: CGFloat, p2y: CGFloat) {
        cx = 3 * p1x
        bx = 3 * (p2x - p1x) - cx
        ax = 1 - cx - bx
        cy = 3 * p1y
        by = 3 * (p2y - p1y) - cy
        ay = 1.0 - cy - by
    }
    func sampleCurveX(_ t: CGFloat) -> CGFloat {
        return ((ax * t + bx) * t + cx) * t
    }
    func sampleCurveY(_ t: CGFloat) -> CGFloat {
        return ((ay * t + by) * t + cy) * t
    }
    func sampleCurveDerivativeX(_ t: CGFloat) -> CGFloat {
        return (3.0 * ax * t + 2.0 * bx) * t + cx
    }
    func solveCurveX(_ x: CGFloat) -> CGFloat {
        var t0, t1, t2, x2, d2: CGFloat
        
        // Firstly try a few iterations of Newton's method -- normally very fast
        t2 = x
        for _ in 0..<8 {
            x2 = sampleCurveX(t2) - x
            if fabs(x2) < epsilon {
                return t2
            }
            d2 = sampleCurveDerivativeX(t2)
            if fabs(x2) < 1e-6 {
                break
            }
            t2 = t2 - x2 / d2
        }
        
        // Fall back to the bisection method for reliability
        t0 = 0
        t1 = 1
        t2 = x
        
        if t2 < t0 {
            return t0
        }
        if t2 > t1 {
            return t1
        }
        
        while t0 < t1 {
            x2 = sampleCurveX(t2)
            if fabs(x2 - x) < epsilon {
                return t2
            }
            if x > x2 {
                t0 = t2
            } else {
                t1 = t2
            }
            t2 = (t1 - t0) * 0.5 + t0
        }
        
        // Failure
        return t2
    }
    
    func solve(_ x: CGFloat) -> CGFloat {
        return sampleCurveY(solveCurveX(x))
    }
}

