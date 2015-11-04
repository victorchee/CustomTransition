//
//  CustomSegue.swift
//  CustomTransition
//
//  Created by Victor Chee on 15/11/4.
//  Copyright © 2015年 VictorChee. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        let sourceView = sourceViewController.view
        let destinationView = destinationViewController.view
        
        guard let superview = sourceView.superview else {
            sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
            return
        }
        destinationView.frame = CGRectMake(0.0, CGRectGetHeight(superview.frame), CGRectGetWidth(destinationView.frame), CGRectGetHeight(destinationView.frame))
        
        superview.insertSubview(destinationView, aboveSubview: sourceView)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            destinationView.frame = CGRectOffset(destinationView.frame, 0.0, -CGRectGetHeight(superview.frame))
            }) { (finished: Bool) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController,
                    animated: false,
                    completion: nil)
        }
    }
}
