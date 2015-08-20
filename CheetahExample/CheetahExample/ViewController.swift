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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create view
        let box = UIView(frame:CGRectMake(100,100,50,50))
        box.backgroundColor = UIColor.blueColor()
        view.addSubview(box)
        
        // Move to right
        /*
        box.cheetah
            .move(100, 0).rotate(M_PI_2).scale(2)
            .wait(2)
            .move(-100, 0).rotate(-M_PI_2).scale(1)
            .wait(2)
            .forever
            .run()
        */
        
        // Move parallel
        /*
        box.cheetah
            .move(100, 0).rotate(M_PI)
            .wait()
            .move(-100, 0).rotate(-M_PI)
            .wait(1.0) // <- wait 1 sec to start next animation
            .move(0, -20).duration(0.4)
            .wait()
            .move(0, 20).duration(0.4)
            .wait(1.0)
            .run()
            .forever
        */
        
        /*
        box.cheetah
            .move(100, 0).duration(1.0).delay(1.0)
            .rotate(M_PI).duration(2.0)
            .wait(1)
            .move(-100, 0).duration(0.4)
            .wait(2)
            .run()
            .forever
        */
        box.cheetah.rotate(M_PI_2).run().forever

        for i in 0...easeOuts.count-1 {
            let ebox = UIView(frame: CGRectMake(20, 200 + 25 * CGFloat(i), 20, 20))
            ebox.backgroundColor = UIColor.brownColor()
            ebox.cheetah
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
                .forever
            view.addSubview(ebox)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

