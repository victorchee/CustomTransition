//
//  CustomTabBarTransition.swift
//  CustomTransition
//
//  Created by qihaijun on 11/5/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class CustomTabBarTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var folds: Int = 3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        toViewController.view.frame = toViewController.view.frame.offsetBy(dx: toViewController.view.frame.width, dy: 0)
        containerView.addSubview(toViewController.view)
        
        var transform = CATransform3DIdentity
        transform.m34 = -0.005
        containerView.layer.sublayerTransform = transform
        
        let size = toViewController.view.frame.size
        let foldWidth = size.width * 0.5 / CGFloat(folds)
        
        var fromViewFolds = [UIView]()
        var toViewFolds = [UIView]()
        
        for i in 0..<folds {
            let offset = CGFloat(i) * foldWidth * 2.0
            
            let leftFromViewFold = createSnapshot(fromView: fromViewController.view, afterUpdate: false, location: offset, left: true)
            leftFromViewFold.layer.position = CGPoint(x: offset, y: size.height / 2.0)
            fromViewFolds.append(leftFromViewFold)
            leftFromViewFold.subviews[1].alpha = 0
            
            let rightFromViewFold = createSnapshot(fromView: fromViewController.view, afterUpdate: false, location: offset + foldWidth, left: false)
            rightFromViewFold.layer.position = CGPoint(x: offset + foldWidth * 2.0, y: size.height / 2.0)
            fromViewFolds.append(rightFromViewFold)
            rightFromViewFold.subviews[1].alpha = 0
            
            let leftToViewFold = createSnapshot(fromView: fromViewController.view, afterUpdate: true, location: offset, left: true)
            leftToViewFold.layer.position = CGPoint(x: 0, y: size.height / 2.0)
            leftToViewFold.layer.transform = CATransform3DMakeRotation(.pi / 2, 0, 1.0, 0)
            toViewFolds.append(leftToViewFold)
            
            let rightToViewFold = createSnapshot(fromView: fromViewController.view, afterUpdate: true, location: offset + foldWidth, left: false)
            rightToViewFold.layer.position = CGPoint(x: 0, y: size.height / 2.0)
            rightToViewFold.layer.transform = CATransform3DMakeRotation(-.pi / 2, 0, 1.0, 0)
            toViewFolds.append(rightToViewFold)
        }
        
        fromViewController.view.frame = fromViewController.view.frame.offsetBy(dx: fromViewController.view.frame.width, dy: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            for i in 0..<self.folds {
                let offset = CGFloat(i) * foldWidth * 2.0
                
                let leftFromView = fromViewFolds[i * 2]
                leftFromView.layer.position = CGPoint(x: size.width, y: size.height / 2.0)
                leftFromView.layer.transform = CATransform3DRotate(transform, .pi / 2, 0, 1.0, 0)
                leftFromView.subviews[1].alpha = 1.0
                
                let rightFromView = fromViewFolds[i * 2 + 1]
                rightFromView.layer.position = CGPoint(x: size.width, y: size.height / 2.0)
                rightFromView.layer.transform = CATransform3DRotate(transform, -.pi / 2, 0, 1.0, 0)
                rightFromView.subviews[1].alpha = 1.0
                
                let leftToView = toViewFolds[i * 2]
                leftToView.layer.position = CGPoint(x: offset, y: size.height / 2.0)
                leftToView.layer.transform = CATransform3DIdentity
                leftToView.subviews[1].alpha = 0
                
                let rightToView = toViewFolds[i * 2 + 1]
                rightToView.layer.position = CGPoint(x: offset + foldWidth * 2.0, y: size.height / 2.0)
                rightToView.layer.transform = CATransform3DIdentity
                rightToView.subviews[1].alpha = 0
            }
            }) { (finished) -> Void in
                for view in toViewFolds {
                    view.removeFromSuperview()
                }
                for view in fromViewFolds {
                    view.removeFromSuperview()
                }
                toViewController.view.frame = containerView.bounds
                fromViewController.view.frame = containerView.bounds
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func createSnapshot(fromView: UIView, afterUpdate: Bool, location: CGFloat, left: Bool) -> UIView {
        let size = fromView.frame.size
        let containerView = fromView.superview
        let foldWidth = size.width * 0.5 / CGFloat(folds)
        
        var snapshotView: UIView
        
        if afterUpdate {
            // for the to- view for some reason the snapshot takes a while to create. Here we place the snapshot within
            // another view, with the same bckground color, so that it is less noticeable when the snapshot initially renders
            snapshotView = UIView(frame: CGRect(x: 0, y: 0, width: foldWidth, height: size.height))
            snapshotView.backgroundColor = fromView.backgroundColor
            let snapshotRect = CGRect(x: location, y: 0, width: foldWidth, height: size.height)
            let snapshotView2 = fromView.resizableSnapshotView(from: snapshotRect, afterScreenUpdates: afterUpdate, withCapInsets: UIEdgeInsets())
            snapshotView.addSubview(snapshotView2!)
        } else {
            // create a regular snapshot
            let snapshotRect = CGRect(x: location, y: 0, width: foldWidth, height: size.height)
            snapshotView = fromView.resizableSnapshotView(from: snapshotRect, afterScreenUpdates: afterUpdate, withCapInsets: UIEdgeInsets())!
        }
        
        let snapshotWithShadowView = addShadow(view: snapshotView, reverse: left)
        
        containerView?.addSubview(snapshotWithShadowView)
        snapshotWithShadowView.layer.anchorPoint = CGPoint(x: left ? 0 : 1.0, y: 0.5)
        
        return snapshotWithShadowView
    }
    
    private func addShadow(view: UIView, reverse: Bool) -> UIView {
        let viewWithShadow = UIView(frame: view.frame)
        let shadowView = UIView(frame: viewWithShadow.bounds)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = shadowView.bounds
        gradientLayer.colors = [UIColor(white: 0, alpha: 0).cgColor, UIColor(white: 0, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: reverse ? 0 : 1.0, y: reverse ? 0.2 : 0)
        gradientLayer.endPoint = CGPoint(x: reverse ? 1.0 : 0, y: reverse ? 0 : 1.0)
        shadowView.layer.insertSublayer(gradientLayer, at: 1)
        
        view.frame = view.bounds
        viewWithShadow.addSubview(view)
        viewWithShadow.addSubview(shadowView)
        
        return viewWithShadow
    }
}
