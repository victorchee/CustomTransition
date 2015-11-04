//
//  CustomTransition.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class CustomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? CollectionViewController else {
            return
        }
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? DetailViewController else {
            return
        }
        
        guard let containerView = transitionContext.containerView() else {
            return
        }
        
        guard let selectedCell = fromViewController.selectedCell else {
            return
        }
        let snapshotView = selectedCell.label.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = containerView.convertRect(selectedCell.label.frame, fromView: selectedCell)
        selectedCell.label.hidden = true
        
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)
        toViewController.view.alpha = 0
        
        // 加入顺序不能错
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotView)
        
        toViewController.label.layoutIfNeeded() // 保证label的frame已经更新
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            snapshotView.center = toViewController.label.center
            toViewController.view.alpha = 1.0
            }) { (finished) -> Void in
                selectedCell.label.hidden = false
                toViewController.label.text = selectedCell.label.text
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(true) // 动画完成后一定要执行此方法，让系统管理navigation
        }
    }
}
