//
//  Cheetah.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

public class Cheetah {
    
    weak var view: UIView?
    weak var link: CADisplayLink?
    
    var lastLoopTime = CFTimeInterval(0)
    var groups: [CheetahGroup]
    var groupIndex: Int = 0
    var repeatCount: Int = 0
    
    init(view: UIView) {
        self.view = view
        groups = [CheetahGroup(view: view)]
    }
    
    var lastProperty: CheetahProperty? {
        get {
            return groups.last?.properties.last
        }
    }
    
    // MARK: Animations
    
    public func size(width: CGFloat, _ height: CGFloat, relative: Bool = false) -> Cheetah {
        addProperty(CheetahViewSizeProperty(view: view, size: CGSize(width: width, height: height), relative: relative))
        return self
    }
    
    public func frame(frame: CGRect) -> Cheetah {
        addProperty(CheetahViewFrameProperty(view: view, frame: frame))
        return self
    }
    
    public func position(x: CGFloat, _ y: CGFloat) -> Cheetah {
        addProperty(CheetahLayerPositionProperty(view: view, position: CGPoint(x: x, y: y)))
        return self
    }
    
    public func move(x: CGFloat, _ y: CGFloat) -> Cheetah {
        addProperty(CheetahLayerPositionProperty(view: view, position: CGPoint(x: x, y: y), relative: true))
        return self
    }
    
    public func rotation(angle: Double) -> Cheetah {
        addProperty(CheetahLayerRotationProperty(view: view, rotation: CGFloat(angle)))
        return self
    }
    
    public func rotate(angle: Double) -> Cheetah {
        addProperty(CheetahLayerRotationProperty(view: view, rotation: CGFloat(angle), relative: true))
        return self
    }
    
    public func scale(scale: CGFloat) -> Cheetah {
        addProperty(CheetahLayerScaleProperty(view: view, scale: CGPoint(x: scale, y: scale)))
        return self
    }
    
    public func scaleXY(x: CGFloat, _ y: CGFloat) -> Cheetah {
        addProperty(CheetahLayerScaleProperty(view: view, scale: CGPoint(x: x, y: y)))
        return self
    }
    
    public func alpha(alpha: CGFloat) -> Cheetah {
        addProperty(CheetahViewAlphaProperty(view: view, alpha: alpha))
        return self
    }
    
    public func backgroundColor(color: UIColor) -> Cheetah {
        addProperty(CheetahViewBackgroundColorProperty(view: view, color: color))
        return self
    }
    
    // MARK: Animation anchor
    
    public func anchor(point: CGPoint) -> Cheetah {
        groups.last?.anchorPoint = point
        return self
    }
    
    public var anchorTop: Cheetah { anchor(CGPointMake(0.5, 1)); return self }
    public var anchorBottom: Cheetah { anchor(CGPointMake(0.5, 1)); return self }
    public var anchorLeft: Cheetah { anchor(CGPointMake(0, 0.5)); return self }
    public var anchorRight: Cheetah { anchor(CGPointMake(1, 0.5)); return self }
    public var anchorBottomLeft: Cheetah { anchor(CGPointMake(0, 1)); return self }
    public var anchorBottomRight: Cheetah { anchor(CGPointMake(1, 1)); return self }
    public var anchorTopLeft: Cheetah { anchor(CGPointMake(0, 0)); return self }
    public var anchorTopRight: Cheetah { anchor(CGPointMake(1, 0)); return self }
    public var anchorCenter: Cheetah { anchor(CGPointMake(0.5, 0.5)); return self }
    
    // MARK: Time & Timings
    
    // Set animation duration for last set item
    public func duration(seconds: CFTimeInterval) -> Cheetah {
        if let lastProperty = lastProperty {
            lastProperty.duration = seconds
        }
        groups.last?.duration = seconds
        return self
    }
    
    // Set delay for last set item
    public func delay(seconds: CFTimeInterval) -> Cheetah {
        lastProperty?.delay = seconds
        return self
    }
    
    // MARK: Easgings
    
    public func ease(easing: Easing) -> Cheetah {
        groups.last?.properties.last?.easing = easing
        return self
    }
    
    public var easeInSine: Cheetah { get { return ease(Easings.easeInSine) } }
    public var easeOutSine: Cheetah { get { return ease(Easings.easeOutSine) } }
    public var easeInOutSine: Cheetah { get { return ease(Easings.easeInOutSine) } }
    public var easeInQuad: Cheetah { get { return ease(Easings.easeInQuad) } }
    public var easeOutQuad: Cheetah { get { return ease(Easings.easeOutQuad) } }
    public var easeInOutQuad: Cheetah { get { return ease(Easings.easeInOutQuad) } }
    public var easeInCubic: Cheetah { get { return ease(Easings.easeInCubic) } }
    public var easeOutCubic: Cheetah { get { return ease(Easings.easeOutCubic) } }
    public var easeInOutCubic: Cheetah { get { return ease(Easings.easeInOutCubic) } }
    public var easeInQuart: Cheetah { get { return ease(Easings.easeInQuart) } }
    public var easeOutQuart: Cheetah { get { return ease(Easings.easeOutQuart) } }
    public var easeInOutQuart: Cheetah { get { return ease(Easings.easeInOutQuart) } }
    public var easeInQuint: Cheetah { get { return ease(Easings.easeInQuint) } }
    public var easeOutQuint: Cheetah { get { return ease(Easings.easeOutQuint) } }
    public var easeInOutQuint: Cheetah { get { return ease(Easings.easeInOutQuint) } }
    public var easeInExpo: Cheetah { get { return ease(Easings.easeInExpo) } }
    public var easeOutExpo: Cheetah { get { return ease(Easings.easeOutExpo) } }
    public var easeInOutExpo: Cheetah { get { return ease(Easings.easeInOutExpo) } }
    public var easeInCirc: Cheetah { get { return ease(Easings.easeInCirc) } }
    public var easeOutCirc: Cheetah { get { return ease(Easings.easeOutCirc) } }
    public var easeInOutCirc: Cheetah { get { return ease(Easings.easeInOutCirc) } }
    public var easeInBack: Cheetah { get { return ease(Easings.easeInBack) } }
    public var easeOutBack: Cheetah { get { return ease(Easings.easeOutBack) } }
    public var easeInOutBack: Cheetah { get { return ease(Easings.easeInOutBack) } }
    public var easeInElastic: Cheetah { get { return ease(Easings.easeInElastic) } }
    public var easeOutElastic: Cheetah { get { return ease(Easings.easeOutElastic) } }
    public var easeInOutElastic: Cheetah { get { return ease(Easings.easeInOutElastic) } }
    public var easeInBounce: Cheetah { get { return ease(Easings.easeInBounce) } }
    public var easeOutBounce: Cheetah { get { return ease(Easings.easeOutBounce) } }
    public var easeInOutBounce: Cheetah { get { return ease(Easings.easeInOutBounce) } }
    
    // MARK: repeating
    
    public var forever: Cheetah {
        get {
            repeatCount = -1
            return self
        }
    }
    
    public func repeatCount(count: Int) -> Cheetah {
        repeatCount = count
        return self
    }
    
    // MARK: Flow control
    
    // Set completion block for each properties
    public func completion(completion: () -> Void) -> Cheetah {
        groups.last?.properties.last?.completion = completion
        return self
    }
    
    // Wait all properties completed
    public func wait(seconds: CFTimeInterval = 0) -> Cheetah {
        // Stack new group to list
        addGroup()
        groups.last?.delay = seconds
        return self
    }
    
    // Remove all animations
    public func remove() {
        // cancel run loop
        link?.invalidate()
        link = nil
        // remove all items
        groups = [CheetahGroup(view: view)]
    }
    
    // MARK: Playing controls
    
    // Start configured animation
    public func run() -> Cheetah {
        // set index to zero
        groupIndex = 0
        // mark start time
        lastLoopTime = CACurrentMediaTime()
        // Prepare first group
        prepare(groups.first)
        // start run loop
        let link = CADisplayLink(target: self, selector: "update:")
        link.frameInterval = 1
        link.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        self.link = link
        return self
    }
    
    // Pause action
    public func pause() {
        link?.paused = true
    }
    
    // Resume action
    public func resume() {
        lastLoopTime = CACurrentMediaTime()
        link?.paused = false
    }
    
    // Resume action
    
    //
    // MARK: Private methods
    //
    
    private func prepare(group: CheetahGroup?) {
        guard let group = group, view = view else {
            return
        }
        // Set anchor point and adjust position
        if group.anchorPoint.x != view.layer.anchorPoint.x || group.anchorPoint.y != view.layer.anchorPoint.y {
            
            // Keep position while changing anchor point
            // http://stackoverflow.com/questions/1968017/changing-my-calayers-anchorpoint-moves-the-view
            
            var newPoint = CGPointMake(view.bounds.size.width * group.anchorPoint.x, view.bounds.size.height * group.anchorPoint.y)
            var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
            
            newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
            oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
            
            view.layer.anchorPoint = group.anchorPoint
            view.layer.position = CGPointMake(
                view.layer.position.x - oldPoint.x + newPoint.x,
                view.layer.position.y - oldPoint.y + newPoint.y
            )
        }
        // Save transform
        group.prepare()
    }
    
    // Runloop
    @objc func update(link: CADisplayLink) {
        if view == nil {
            // end animation if view is destructed
            remove()
            return
        }
        // duration between each run loop
        let dt = link.timestamp - lastLoopTime
        let group = groups[groupIndex]
        lastLoopTime = link.timestamp
        if group.proceed(dt) {
            if ++groupIndex >= groups.count {
                if repeatCount == 0 {
                    remove()
                    return
                }
                groupIndex = 0
                repeatCount--
            }
            // prepare next group
            prepare(groups[groupIndex])
        }
    }
    
    // Add property to current group
    public func addProperty(prop: CheetahProperty) {
        if let group = groups.last {
            prop.group = group
            prop.duration = group.duration
            group.properties.append(prop)
        }
    }
    
    // Add new group to groups
    func addGroup() -> CheetahGroup {
        let group = CheetahGroup(view: view)
        if let last = groups.last {
            group.anchorPoint = last.anchorPoint
        }
        groups.append(group)
        return group
    }
    
}
