//
//  ViewController.swift
//  CheetahExample
//
//  Created by Suguru Namura on 2015/08/19.
//  Copyright © 2015年 Suguru Namura.
//

import UIKit
import Cheetah

class ViewController: UIViewController {
    
    let easeIns = [
        Easings.linear,
        Easings.easeInSine,
        Easings.easeInQuad,
        Easings.easeInQuart,
        Easings.easeInQuint,
        Easings.easeInCirc,
        Easings.easeInCubic,
        Easings.easeInExpo,
        Easings.easeInBack,
        Easings.easeInBounce,
        Easings.easeInElastic,
    ]
    
    let easeOuts = [
        Easings.linear,
        Easings.easeOutSine,
        Easings.easeOutQuad,
        Easings.easeOutQuart,
        Easings.easeOutQuint,
        Easings.easeOutCirc,
        Easings.easeOutCubic,
        Easings.easeOutExpo,
        Easings.easeOutBack,
        Easings.easeOutBounce,
        Easings.easeOutElastic,
    ]
    
    var box: UIView!
    var box2: UIView!
    var label: UILabel!
    var boxes: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create view
        box = UIView(frame:CGRectMake(50,50,50,50))
        box.backgroundColor = UIColor.blueColor()
        view.addSubview(box)
        
        box2 = UIView(frame: CGRectMake(150, 50, 50, 50))
        box2.backgroundColor = UIColor.blueColor()
        
        view.addSubview(box2)
        
        label = UILabel(frame: CGRectMake(200, 100, 200, 40))
        label.text = "HELLO CHEETAH!"
        view.addSubview(label)

        boxes = [UIView]()
        boxes.reserveCapacity(easeOuts.count)
        
        for i in 0...easeOuts.count-1 {
            let ebox = UIView(frame: CGRectMake(20, 200 + 25 * CGFloat(i), 20, 20))
            ebox.backgroundColor = UIColor.brownColor()
            view.addSubview(ebox)
            boxes.append(ebox)
        }
        
        startAnimate()
    }
    
    func startAnimate() {
        
        box.cheetah
            .rotate(M_PI_2)
            .run()
        
        box2.cheetah
            .borderWidth(5)
            .borderColor(UIColor.redColor())
            .cornerRadius(25)
            .wait()
            .borderWidth(0)
            .borderColor(UIColor.blackColor())
            .cornerRadius(0)
            .run()
        
        label.cheetah
            .move(0, 30).duration(0.5).easeOutBack
            .textColor(UIColor.redColor())
            .wait(1)
            .move(0, -30).duration(0.5).easeOutBack
            .textColor(UIColor.blueColor())
            .wait(1)
            .run()

        for i in 0..<boxes.count {
            let box = boxes[i]
            box.cheetah
                .move(200, 0)
                    .ease(easeOuts[i])
                    .duration(2)
                .rotate(M_PI*2)
                    .ease(easeOuts[i])
                    .duration(2)
                .wait()
                .move(-200, 0)
                    .ease(easeIns[i])
                    .duration(2)
                .rotate(-M_PI*2)
                    .ease(easeIns[i])
                    .duration(2)
                .wait(1.0)
                .run()
                //.forever
        }
    }
    
    @IBAction func didTapAnimate(sender: AnyObject) {
        startAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

