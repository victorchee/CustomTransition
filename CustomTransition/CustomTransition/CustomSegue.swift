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
        let sourceView = source.view
        let destinationView = destination.view
        
        sourceView?.addSubview(destinationView!)
        
        destinationView?.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            destinationView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (finished) -> Void in
                destinationView?.removeFromSuperview()
                self.source.present(self.destination, animated: false, completion: nil)
        }
    }
}
