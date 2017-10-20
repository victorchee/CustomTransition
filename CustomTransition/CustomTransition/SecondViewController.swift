//
//  SecondViewController.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBAction func dismiss(_ sender: UIButton) {
        (transitioningDelegate as! UIViewController).dismiss(animated: true, completion: nil)
    }
}
