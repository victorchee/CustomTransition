//
//  DetailViewController.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var label: UILabel!
    
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    @IBAction func edgePan(sender: UIScreenEdgePanGestureRecognizer) {
        let progress = sender.translationInView(view).x / view.bounds.width
        if sender.state == .Began {
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewControllerAnimated(true)
        } else if sender.state == .Changed {
            percentDrivenTransition?.updateInteractiveTransition(progress)
        } else if sender.state == .Cancelled || sender.state == .Ended {
            if progress > 0.5 {
                percentDrivenTransition?.finishInteractiveTransition()
            } else {
                percentDrivenTransition?.cancelInteractiveTransition()
            }
            percentDrivenTransition = nil
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Pop {
            return CustomPopTransition()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is CustomPopTransition {
            return percentDrivenTransition
        } else {
            return nil
        }
    }
}
