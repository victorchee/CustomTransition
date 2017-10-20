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
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePan(_:)))
        edgePanGesture.edges = UIRectEdge.right
        view.addGestureRecognizer(edgePanGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondViewController {
            let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePan(_:)))
            edgePanGesture.edges = UIRectEdge.left
            destination.view.addGestureRecognizer(edgePanGesture)
            
            destination.transitioningDelegate = self
        }
        
        super.prepare(for: segue, sender: sender)
    }
    
    @objc func edgePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        let window = UIApplication.shared.keyWindow!
        let progress = abs(sender.translation(in: window).x / window.bounds.width)
        if sender.state == .began {
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            if sender.edges == .right {
                performSegue(withIdentifier: "Modal", sender: sender)
            } else {
                dismiss(animated: true, completion: nil)
            }
        } else if sender.state == .changed {
            percentDrivenTransition?.update(progress)
        } else if sender.state == .cancelled || sender.state == .ended {
            if progress > 0.5 {
                percentDrivenTransition?.finish()
            } else {
                percentDrivenTransition?.cancel()
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
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDrivenTransition
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDrivenTransition
    }
}
