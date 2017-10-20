//
//  CustomPopTransition.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class CustomPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? DetailViewController else {
            return
        }
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CollectionViewController else {
            return
        }
        let containerView = transitionContext.containerView
        
        let snapshotView = fromViewController.label.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = containerView.convert(fromViewController.label.frame, from: fromViewController.view)
        fromViewController.label.isHidden = true
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        guard let selectedCell = toViewController.selectedCell else {
            return
        }
        selectedCell.label.isHidden = true
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        containerView.addSubview(snapshotView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            snapshotView?.frame = containerView.convert(selectedCell.label.frame, from: selectedCell)
            fromViewController.view.alpha = 0
            }) { (finished) -> Void in
                selectedCell.label.isHidden = false
                snapshotView?.removeFromSuperview()
                fromViewController.label.isHidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
