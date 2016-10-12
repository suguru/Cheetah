//
//  Spring.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/31.
//  Copyright © 2015年 Suguru Namura. All rights reserved.
//

import UIKit

private let tolerence: Double = 1 / 100000
private let maxDT: Double = 16 / 1000

// Spring calculation
class Spring {
    
    let tension: Double
    let friction: Double

    var velocity: Double = 0
    var current: Double = 0
    var elapsed: Double = 0
    var ended: Bool = false
   
    init(tension: Double = 500, friction: Double = 20) {
        self.tension = tension
        self.friction = friction
    }
    
    fileprivate func accelerationFor(_ x: Double, _ v: Double) -> Double {
        return (-tension * x) - (friction * v)
    }
    
    fileprivate func proceedStep(_ stepSize: Double) {
        
        elapsed += stepSize
        
        if ended {
            return
        }
        
        let x = current - 1
        let v = velocity
        
        let ax = v
        let av = accelerationFor(x, v)
        
        let bx = v + av * stepSize * 0.5
        let bv = accelerationFor(x + ax * stepSize * 0.5, bx)
        
        let cx = v + bv * stepSize * 0.5
        let cv = accelerationFor(x + bx * stepSize * 0.5, cx)
        
        let dx = v + cv * stepSize
        let dv = accelerationFor(x + cx * stepSize, dx)
        
        let dxdt = 1.0 / 6.0 * (ax + 2.0 * (bx + cx) + dx)
        let dvdt = 1.0 / 6.0 * (av + 2.0 * (bv + cv) + dv)
        let afterx = x + dxdt * stepSize
        let afterv = v + dvdt * stepSize
        
        ended = abs(afterx) < tolerence && abs(afterv) < tolerence
        
        if ended {
            current = 1
            velocity = 0
        } else {
            current = 1 + afterx
            velocity = afterv
        }
    }
    
    func proceed(_ dt: Double) {
        var dt = dt
        while dt > maxDT {
            proceedStep(maxDT)
            dt -= maxDT
        }
        if dt > 0 {
            proceedStep(dt)
        }
    }
    
}
