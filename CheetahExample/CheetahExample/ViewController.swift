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
        box = UIView(frame:CGRect(x: 50,y: 50,width: 50,height: 50))
        box.backgroundColor = UIColor.blue
        view.addSubview(box)
        
        box2 = UIView(frame: CGRect(x: 150, y: 50, width: 50, height: 50))
        box2.backgroundColor = UIColor.blue
        
        view.addSubview(box2)
        
        label = UILabel(frame: CGRect(x: 200, y: 100, width: 200, height: 40))
        label.text = "HELLO CHEETAH!"
        view.addSubview(label)

        boxes = [UIView]()
        boxes.reserveCapacity(easeOuts.count)
        
        for i in 0..<easeOuts.count {
            let ebox = UIView(frame: CGRect(x: 20, y: 200 + 25 * CGFloat(i), width: 20, height: 20))
            ebox.backgroundColor = UIColor.brown
            view.addSubview(ebox)
            boxes.append(ebox)
        }
        
        sboxes = [UIView]()
        sboxes.reserveCapacity(3)
        
        for i in 0..<sboxes.capacity {
            let sbox = UIView(frame: CGRect(x: 20, y: 200 + 25 * CGFloat(i+easeOuts.count+1), width: 20, height: 20))
            sbox.backgroundColor = UIColor.green
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
            .borderColor(UIColor.red)
            .cornerRadius(25)
            .wait()
            .borderWidth(0)
            .borderColor(UIColor.black)
            .cornerRadius(0)
            .run()
        
        label.cheetah
            .move(0, 30).duration(0.5).easeOutBack
            .textColor(UIColor.red)
            .wait(1)
            .move(0, -30).duration(0.5).easeOutBack
            .textColor(UIColor.blue)
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
    
    @IBAction func didTapAnimate(_ sender: AnyObject) {
        startAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

