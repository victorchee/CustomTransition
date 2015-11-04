//
//  CustomUnwindSegue.swift
//  CustomTransition
//
//  Created by Victor Chee on 15/11/4.
//  Copyright © 2015年 VictorChee. All rights reserved.
//

import UIKit

class CustomUnwindSegue: UIStoryboardSegue {
    override func perform() {
        let sourceView = sourceViewController.view
        let destinationView = destinationViewController.view
        
        guard let superview = destinationView.superview else {
            sourceViewController.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        superview.insertSubview(sourceView, aboveSubview: destinationView)
        destinationView.frame = sourceView.frame
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveLinear, animations: { () -> Void in
            sourceView.frame = CGRectOffset(sourceView.frame, 0, CGRectGetHeight(superview.frame))
            }) { (finished) -> Void in
                self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
