//
//  CustomPopTransition.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class CustomPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? DetailViewController else {
            return
        }
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? CollectionViewController else {
            return
        }
        guard let containerView = transitionContext.containerView() else {
            return
        }
        
        let snapshotView = fromViewController.label.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = containerView.convertRect(fromViewController.label.frame, fromView: fromViewController.view)
        fromViewController.label.hidden = true
        
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)
        guard let selectedCell = toViewController.selectedCell else {
            return
        }
        selectedCell.label.hidden = true
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        containerView.addSubview(snapshotView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            snapshotView.frame = containerView.convertRect(selectedCell.label.frame, fromView: selectedCell)
            fromViewController.view.alpha = 0
            }) { (finished) -> Void in
                selectedCell.label.hidden = false
                snapshotView.removeFromSuperview()
                fromViewController.label.hidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
