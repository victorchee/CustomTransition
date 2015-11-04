//
//  FirstViewController.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIViewControllerTransitioningDelegate {
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "edgePan:")
        edgePanGesture.edges = UIRectEdge.Right
        view.addGestureRecognizer(edgePanGesture)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? SecondViewController {
            let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "edgePan:")
            edgePanGesture.edges = UIRectEdge.Left
            destination.view.addGestureRecognizer(edgePanGesture)
            
            destination.transitioningDelegate = self
        }
        
        super.prepareForSegue(segue, sender: sender)
    }
    
    func edgePan(sender: UIScreenEdgePanGestureRecognizer) {
        let window = UIApplication.sharedApplication().keyWindow!
        let progress = abs(sender.translationInView(window).x / window.bounds.width)
        if sender.state == .Began {
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            if sender.edges == .Right {
                performSegueWithIdentifier("Modal", sender: sender)
            } else {
                dismissViewControllerAnimated(true, completion: nil)
            }
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
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomModalTransition()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissTransition()
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDrivenTransition
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDrivenTransition
    }
}
