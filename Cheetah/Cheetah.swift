//
//  Cheetah.swift
//  Cheetah
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit

open class Cheetah {
    
    weak var view: UIView?
    
    var id: UInt32 = 0
    var groups: [CheetahGroup]
    var groupIndex: Int = 0
    var repeatCount: Int = 0
    var paused: Bool = false
    var running: Bool = false
    
    init(view: UIView) {
        self.view = view
        groups = []
    }
    
    var lastProperty: CheetahProperty? {
        get {
            return groups.last?.properties.last
        }
    }
    
    // MARK: Animations
    
    open func size(_ width: CGFloat, _ height: CGFloat, relative: Bool = false) -> Cheetah {
        return addProperty(CheetahViewSizeProperty(view: view, size: CGSize(width: width, height: height), relative: relative))
    }
    
    open func frame(_ frame: CGRect) -> Cheetah {
        return addProperty(CheetahViewFrameProperty(view: view, frame: frame))
    }
    
    open func position(_ x: CGFloat, _ y: CGFloat) -> Cheetah {
        return addProperty(CheetahLayerPositionProperty(view: view, position: CGPoint(x: x, y: y)))
    }
    
    open func move(_ x: CGFloat, _ y: CGFloat) -> Cheetah {
        return addProperty(CheetahLayerPositionProperty(view: view, position: CGPoint(x: x, y: y), relative: true))
    }
    
    open func rotation(_ angle: Double) -> Cheetah {
        return addProperty(CheetahLayerRotationProperty(view: view, rotation: CGFloat(angle)))
    }
    
    open func rotate(_ angle: Double) -> Cheetah {
        return addProperty(CheetahLayerRotationProperty(view: view, rotation: CGFloat(angle), relative: true))
    }
    
    open func scale(_ scale: CGFloat) -> Cheetah {
        return addProperty(CheetahLayerScaleProperty(view: view, scale: CGPoint(x: scale, y: scale)))
    }
    
    open func scaleXY(_ x: CGFloat, _ y: CGFloat) -> Cheetah {
        return addProperty(CheetahLayerScaleProperty(view: view, scale: CGPoint(x: x, y: y)))
    }
    
    open func alpha(_ alpha: CGFloat) -> Cheetah {
        return addProperty(CheetahViewAlphaProperty(view: view, alpha: alpha))
    }
    
    open func backgroundColor(_ color: UIColor) -> Cheetah {
        return addProperty(CheetahViewBackgroundColorProperty(view: view, color: color))
    }
    
    open func borderWidth(_ borderWidth: CGFloat) -> Cheetah {
        return addProperty(CheetahLayerBorderWidthProperty(view: view, borderWidth: borderWidth))
    }
    
    open func borderColor(_ borderColor: UIColor) -> Cheetah {
        return addProperty(CheetahLayerBorderColorProperty(view: view, borderColor: borderColor))
    }
    
    open func cornerRadius(_ cornerRadius: CGFloat) -> Cheetah {
        return addProperty(CheetahLayerCornerRadiusProperty(view: view, cornerRadius: cornerRadius))
    }
    
    open func textColor(_ color: UIColor) -> Cheetah {
        return addProperty(CheetahTextColorProperty(view: view, textColor: color))
    }
    
    open func constraint(_ constraint: NSLayoutConstraint!, constant: CGFloat) -> Cheetah {
        return addProperty(CheetahConstraintProperty(view: view, constraint: constraint, constant: constant))
    }
    
    // MARK: Animation anchor
    
    open func anchor(_ point: CGPoint) -> Cheetah {
        groups.last?.anchorPoint = point
        return self
    }
    
    open var anchorTop: Cheetah { return anchor(CGPoint(x: 0.5, y: 1)) }
    open var anchorBottom: Cheetah { return anchor(CGPoint(x: 0.5, y: 1)) }
    open var anchorLeft: Cheetah { return anchor(CGPoint(x: 0, y: 0.5)) }
    open var anchorRight: Cheetah { return anchor(CGPoint(x: 1, y: 0.5)) }
    open var anchorBottomLeft: Cheetah { return anchor(CGPoint(x: 0, y: 1)) }
    open var anchorBottomRight: Cheetah { return anchor(CGPoint(x: 1, y: 1)) }
    open var anchorTopLeft: Cheetah { return anchor(CGPoint(x: 0, y: 0)) }
    open var anchorTopRight: Cheetah { return anchor(CGPoint(x: 1, y: 0)) }
    open var anchorCenter: Cheetah { return anchor(CGPoint(x: 0.5, y: 0.5)) }
    
    // MARK: Time & Timings
    
    // Set animation duration for last set item
    open func duration(_ seconds: CFTimeInterval) -> Cheetah {
        if let lastProperty = lastProperty {
            lastProperty.duration = seconds
        }
        groups.last?.duration = seconds
        return self
    }
    
    // Set delay for last set item
    open func delay(_ seconds: CFTimeInterval) -> Cheetah {
        lastProperty?.delay = seconds
        return self
    }
    
    // MARK: Easgings
    
    open func ease(_ easing: @escaping Easing) -> Cheetah {
        groups.last?.properties.last?.easing = easing
        return self
    }
    
    open var easeInSine: Cheetah { get { return ease(Easings.easeInSine) } }
    open var easeOutSine: Cheetah { get { return ease(Easings.easeOutSine) } }
    open var easeInOutSine: Cheetah { get { return ease(Easings.easeInOutSine) } }
    open var easeInQuad: Cheetah { get { return ease(Easings.easeInQuad) } }
    open var easeOutQuad: Cheetah { get { return ease(Easings.easeOutQuad) } }
    open var easeInOutQuad: Cheetah { get { return ease(Easings.easeInOutQuad) } }
    open var easeInCubic: Cheetah { get { return ease(Easings.easeInCubic) } }
    open var easeOutCubic: Cheetah { get { return ease(Easings.easeOutCubic) } }
    open var easeInOutCubic: Cheetah { get { return ease(Easings.easeInOutCubic) } }
    open var easeInQuart: Cheetah { get { return ease(Easings.easeInQuart) } }
    open var easeOutQuart: Cheetah { get { return ease(Easings.easeOutQuart) } }
    open var easeInOutQuart: Cheetah { get { return ease(Easings.easeInOutQuart) } }
    open var easeInQuint: Cheetah { get { return ease(Easings.easeInQuint) } }
    open var easeOutQuint: Cheetah { get { return ease(Easings.easeOutQuint) } }
    open var easeInOutQuint: Cheetah { get { return ease(Easings.easeInOutQuint) } }
    open var easeInExpo: Cheetah { get { return ease(Easings.easeInExpo) } }
    open var easeOutExpo: Cheetah { get { return ease(Easings.easeOutExpo) } }
    open var easeInOutExpo: Cheetah { get { return ease(Easings.easeInOutExpo) } }
    open var easeInCirc: Cheetah { get { return ease(Easings.easeInCirc) } }
    open var easeOutCirc: Cheetah { get { return ease(Easings.easeOutCirc) } }
    open var easeInOutCirc: Cheetah { get { return ease(Easings.easeInOutCirc) } }
    open var easeInBack: Cheetah { get { return ease(Easings.easeInBack) } }
    open var easeOutBack: Cheetah { get { return ease(Easings.easeOutBack) } }
    open var easeInOutBack: Cheetah { get { return ease(Easings.easeInOutBack) } }
    open var easeInElastic: Cheetah { get { return ease(Easings.easeInElastic) } }
    open var easeOutElastic: Cheetah { get { return ease(Easings.easeOutElastic) } }
    open var easeInOutElastic: Cheetah { get { return ease(Easings.easeInOutElastic) } }
    open var easeInBounce: Cheetah { get { return ease(Easings.easeInBounce) } }
    open var easeOutBounce: Cheetah { get { return ease(Easings.easeOutBounce) } }
    open var easeInOutBounce: Cheetah { get { return ease(Easings.easeInOutBounce) } }
    
    // MARK:
    open func spring(tension: Double = 50, friction: Double = 3) -> Cheetah {
        lastProperty?.spring = Spring(tension: tension, friction: friction)
        return self
    }
    
    
    // MARK: repeating
    
    open var forever: Cheetah {
        get {
            repeatCount = -1
            return self
        }
    }
    
    @discardableResult open func repeatCount(_ count: Int) -> Cheetah {
        repeatCount = count
        return self
    }
    
    // MARK: Flow control
    
    // Set completion block for each properties
    @discardableResult open func completion(_ completion: (() -> Void)?) -> Cheetah {
        groups.last?.properties.last?.completion = completion
        return self
    }
    
    // Wait all properties completed
    open func wait(_ seconds: CFTimeInterval = 0) -> Cheetah {
        // Stack new group to list
        addGroup()
        groups.last?.delay = seconds
        return self
    }
    
    // Remove all animations
    @discardableResult open func remove() -> Cheetah {
        // remove all items
        groups = []
        running = false
        groupIndex = 0
        return self
    }
    
    // MARK: Playing controls
    
    // Start configured animation
    @discardableResult open func run() -> Cheetah {
        if running {
            return self
        }
        running = true
        // set index to zero
        groupIndex = 0
        // mark start time
        // Prepare first group
        prepare(groups.first)
        CheetahManager.sharedInstance.add(self)
        return self
    }
    
    // Pause action
    open func pause() {
        paused = true
    }
    
    // Resume action
    open func resume() {
        paused = false
    }
    
    // Resume action
    
    //
    // MARK: Private methods
    //
    
    fileprivate func prepare(_ group: CheetahGroup?) {
        guard let group = group, let view = view else {
            return
        }
        // Set anchor point and adjust position
        if group.anchorPoint.x != view.layer.anchorPoint.x || group.anchorPoint.y != view.layer.anchorPoint.y {
            
            // Keep position while changing anchor point
            // http://stackoverflow.com/questions/1968017/changing-my-calayers-anchorpoint-moves-the-view
            
            var newPoint = CGPoint(x: view.bounds.size.width * group.anchorPoint.x, y: view.bounds.size.height * group.anchorPoint.y)
            var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
            
            newPoint = newPoint.applying(view.transform)
            oldPoint = oldPoint.applying(view.transform)
            
            view.layer.anchorPoint = group.anchorPoint
            view.layer.position = CGPoint(
                x: view.layer.position.x - oldPoint.x + newPoint.x,
                y: view.layer.position.y - oldPoint.y + newPoint.y
            )
        }
        // Save transform
        group.prepare()
    }
    
    // proceed animation
    // returns true when completed
    func proceed(_ dt: CFTimeInterval) -> Bool {
        if view == nil {
            // end animation if view is destructed
            return true
        }
        if paused {
            // not proceed when paused
            return false
        }
        if groupIndex >= groups.count {
            // end if group index is over
            return true
        }
        // duration between each run loop
        let group = groups[groupIndex]
        if group.proceed(dt) {
            groupIndex += 1
            if groupIndex >= groups.count {
                if repeatCount == 0 {
                    return true
                }
                groupIndex = 0
                repeatCount -= 1
            }
            // prepare next group
            prepare(groups[groupIndex])
        }
        return false
    }
    
    // Add property to current group
    @discardableResult open func addProperty(_ prop: CheetahProperty) -> Cheetah {
        if groups.count == 0 {
            addGroup()
        }
        if let group = groups.last {
            prop.group = group
            prop.duration = group.duration
            group.properties.append(prop)
        }
        return self
    }
    
    // Add new group to groups
    @discardableResult func addGroup() -> CheetahGroup {
        let group = CheetahGroup(view: view)
        if let last = groups.last {
            group.anchorPoint = last.anchorPoint
        }
        groups.append(group)
        return group
    }
    
}
