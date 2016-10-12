//
//  CheetahManager.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/22.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

open class CheetahManager {
    
    open static let sharedInstance = CheetahManager()
    
    var cheetahs = [UInt32 : Cheetah]()
    var counter: UInt32
    var displayLink: CADisplayLink?
    var lastLoopTime: CFTimeInterval
    
    init() {
        counter = 0
        lastLoopTime = 0
    }
    
    // Add cheetah to manager
    func add(_ cheetah: Cheetah) {
        
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        // assign ID if does not exist
        if cheetah.id == 0 {
            counter += 1
            if counter == 0 {
                counter = 1
            }
            cheetah.id = counter
        }
        
        // add to management dictionary
        cheetahs[cheetah.id] = cheetah
        
        // start run loop
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(CheetahManager.update(_:)))
            lastLoopTime = CACurrentMediaTime()
            displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        }
    }
    
    @objc func update(_ displayLink: CADisplayLink) {
        
        let dt = displayLink.timestamp - lastLoopTime
        defer {
            lastLoopTime = displayLink.timestamp
        }
        
        for (_, cheetah) in cheetahs {
            if cheetah.proceed(dt) {
                // remove cheetah from UIView
                if let view = cheetah.view {
                    objc_setAssociatedObject(view, &cheetahAssociationKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
                cheetah.remove()
                // remove cheetah from dic
                cheetahs[cheetah.id] = nil
            }
        }
        
        if cheetahs.count == 0 {
            displayLink.invalidate()
            self.displayLink = nil
        }
    }
    
    open func pause() {
        guard let displayLink = displayLink else {
            return
        }
        displayLink.isPaused = true
    }
    
    open func resume() {
        guard let displayLink = displayLink else {
            return
        }
        lastLoopTime = CACurrentMediaTime()
        displayLink.isPaused = false
    }
    
    open func stop() {
        guard let displayLink = displayLink else {
            return
        }
        displayLink.invalidate()
        self.displayLink = nil
    }
}
