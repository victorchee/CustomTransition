//
//  CustomDismissTransition.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class CustomDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? SecondViewController else {
            return
        }
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UITabBarController else {
            return
        }
        guard let containerView = transitionContext.containerView() else {
            return
        }
        containerView.addSubview(toViewController.view)
        
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
        
        let initialFrame = transitionContext.initialFrameForViewController(fromViewController)
        toViewController.view.frame = initialFrame
        toViewController.view.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        toViewController.view.layer.position = CGPoint(x: 0, y: initialFrame.height / 2.0)
        toViewController.view.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 1, 0)
        
        let shadowLayer = CAGradientLayer()
        shadowLayer.colors = [UIColor(white: 0, alpha: 1.0).CGColor, UIColor(white: 0, alpha: 0.5).CGColor, UIColor(white: 1, alpha: 0.5).CGColor]
        shadowLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shadowLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        shadowLayer.frame = initialFrame
        
        let shadowView = UIView(frame: initialFrame)
        shadowView.backgroundColor = UIColor.clearColor()
        shadowView.layer.addSublayer(shadowLayer)
        fromViewController.view.addSubview(shadowView)
        shadowView.alpha = 1
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            toViewController.view.layer.transform = CATransform3DIdentity
            shadowView.alpha = 0
            }) { (finished) -> Void in
                toViewController.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                toViewController.view.layer.position = CGPoint(x: CGRectGetMidX(initialFrame), y: CGRectGetMidY(initialFrame))
                shadowView.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
