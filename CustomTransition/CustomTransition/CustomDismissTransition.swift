//
//  CustomDismissTransition.swift
//  CustomTransition
//
//  Created by qihaijun on 11/4/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class CustomDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? SecondViewController else {
            return
        }
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? UITabBarController else {
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
        
        let initialFrame = transitionContext.initialFrame(for: fromViewController)
        toViewController.view.frame = initialFrame
        toViewController.view.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        toViewController.view.layer.position = CGPoint(x: 0, y: initialFrame.height / 2.0)
        toViewController.view.layer.transform = CATransform3DMakeRotation(.pi / 2, 0, 1, 0)
        
        let shadowLayer = CAGradientLayer()
        shadowLayer.colors = [UIColor(white: 0, alpha: 1.0).cgColor, UIColor(white: 0, alpha: 0.5).cgColor, UIColor(white: 1, alpha: 0.5).cgColor]
        shadowLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shadowLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        shadowLayer.frame = initialFrame
        
        let shadowView = UIView(frame: initialFrame)
        shadowView.backgroundColor = UIColor.clear
        shadowView.layer.addSublayer(shadowLayer)
        fromViewController.view.addSubview(shadowView)
        shadowView.alpha = 1
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            toViewController.view.layer.transform = CATransform3DIdentity
            shadowView.alpha = 0
            }) { (finished) -> Void in
                toViewController.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                toViewController.view.layer.position = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
                shadowView.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
