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
        sourceView.superview?.insertSubview(destinationView, atIndex: 0)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            sourceView.transform = CGAffineTransformMakeScale(0.05, 0.05)
            }) { (finished) -> Void in
                destinationView.removeFromSuperview()
                self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
