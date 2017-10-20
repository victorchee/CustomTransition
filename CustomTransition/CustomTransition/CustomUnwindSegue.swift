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
        let sourceView = source.view
        let destinationView = destination.view
        sourceView?.superview?.insertSubview(destinationView!, at: 0)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            sourceView?.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
            }) { (finished) -> Void in
                destinationView?.removeFromSuperview()
                self.source.dismiss(animated: false, completion: nil)
        }
    }
}
