//
//  OneViewController.swift
//  CustomTransition
//
//  Created by Victor Chee on 15/11/4.
//  Copyright © 2015年 VictorChee. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    @IBAction func unwindFromViewController(sender: UIStoryboardSegue) {}
    
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
        if identifier == "UnwindSegue" {
            return CustomUnwindSegue(identifier: identifier, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
            })
        }
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
    }
}
