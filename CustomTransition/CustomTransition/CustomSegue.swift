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
        
        sourceView.addSubview(destinationView)
        
        destinationView.transform = CGAffineTransformMakeScale(0.05, 0.05)
                
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            destinationView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (finished) -> Void in
                destinationView.removeFromSuperview()
                self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
        }
    }
}
