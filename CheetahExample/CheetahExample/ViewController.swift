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
    var sboxes: [UIView]!
    
    @IBOutlet weak var autolayoutBox: UIView!
    @IBOutlet weak var autolayoutBottom: NSLayoutConstraint!
    
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
        
        for i in 0..<easeOuts.count {
            let ebox = UIView(frame: CGRectMake(20, 200 + 25 * CGFloat(i), 20, 20))
            ebox.backgroundColor = UIColor.brownColor()
            view.addSubview(ebox)
            boxes.append(ebox)
        }
        
        sboxes = [UIView]()
        sboxes.reserveCapacity(3)
        
        for i in 0..<sboxes.capacity {
            let sbox = UIView(frame: CGRectMake(20, 200 + 25 * CGFloat(i+easeOuts.count+1), 20, 20))
            sbox.backgroundColor = UIColor.greenColor()
            view.addSubview(sbox)
            sboxes.append(sbox)
        }
        
        startAnimate()
    }
    
    func startAnimate() {
        
        /*
        box.cheetah
            .rotate(1).duration(1)
            .scale(2).duration(2)
            .move(100, 100).duration(2)
            .wait()
            .move(-100, -100).duration(1)
            .run()
        */
        
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
                .rotate(5)
                //.rotate(M_PI*2)
                    .ease(easeOuts[i])
                    .duration(2)
                .wait()
                .move(-190, 0)
                    .ease(easeIns[i])
                    .duration(2)
                .rotate(5)
                //.rotate(-M_PI*2)
                    .ease(easeIns[i])
                    .duration(2)
                .wait()
                .run()
                //.forever
        }
        
        sboxes[0].cheetah
                .move(200, 0)
                    .spring()
                    .duration(2)
                .wait()
                .move(-200, 0)
                    .spring()
                    .duration(2)
                .run()
        
        sboxes[1].cheetah
                .move(200, 0)
                    .spring(tension: 100, friction: 2)
                    .duration(2)
                .wait()
                .move(-200, 0)
                    .spring(tension: 100, friction: 2)
                    .duration(2)
                .run()
        
        sboxes[2].cheetah
                .move(200, 0)
                    .spring(tension: 10, friction: 8)
                    .duration(2)
                .wait()
                .move(-200, 0)
                    .spring(tension: 10, friction: 8)
                    .duration(2)
                .run()
        
        autolayoutBox.cheetah
                .constraint(autolayoutBottom, constant: 100)
                .duration(2)
                .run()
    }
    
    @IBAction func didTapAnimate(sender: AnyObject) {
        startAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

