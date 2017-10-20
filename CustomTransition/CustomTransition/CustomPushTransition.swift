//
//  CustomTransition.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class CustomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CollectionViewController else {
            return
        }
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? DetailViewController else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        guard let selectedCell = fromViewController.selectedCell else {
            return
        }
        let snapshotView = selectedCell.label.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = containerView.convert(selectedCell.label.frame, from: selectedCell)
        selectedCell.label.isHidden = true
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        toViewController.view.alpha = 0
        
        // 加入顺序不能错
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotView!)
        
        toViewController.label.layoutIfNeeded() // 保证label的frame已经更新
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            snapshotView?.center = toViewController.label.center
            toViewController.view.alpha = 1.0
            }) { (finished) -> Void in
                selectedCell.label.isHidden = false
                toViewController.label.text = selectedCell.label.text
                snapshotView?.removeFromSuperview()
                transitionContext.completeTransition(true) // 动画完成后一定要执行此方法，让系统管理navigation
        }
    }
}
