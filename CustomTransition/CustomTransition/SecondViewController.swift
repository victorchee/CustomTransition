//
//  SecondViewController.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBAction func dismiss(sender: UIButton) {
        (transitioningDelegate as! UIViewController).dismissViewControllerAnimated(true, completion: nil)
    }
}
