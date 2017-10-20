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
    
    @IBAction func edgePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        let progress = sender.translation(in: view).x / view.bounds.width
        if sender.state == .began {
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
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
