//
//  TabBarController.swift
//  CustomTransition
//
//  Created by qihaijun on 11/5/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        addObserver(self, forKeyPath: "selectedViewController", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "selectedVieController" {
            
        }
    }
    
//    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return CustomTabBarTransition()
//    }
}
