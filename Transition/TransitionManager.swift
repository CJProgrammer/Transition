//
//  TransitionManager.swift
//  Transition
//
//  Created by CJ on 2017/7/5.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    fileprivate var presenting = false
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let screenViews : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        let listViewController = self.presenting ? (screenViews.to as! ListViewController) : (screenViews.from as! ListViewController)
        let bottomViewController = self.presenting ? (screenViews.from as UIViewController) : (screenViews.to as UIViewController)
        
        let listView = listViewController.view
        let bottomView = bottomViewController.view
        let containerView = transitionContext.containerView
        
        containerView.addSubview(bottomView!)
        containerView.addSubview(listView!)
        
        if (self.presenting){
            setToTopLeft(listViewController)
        }
        
        let duration = self.transitionDuration(using: transitionContext)
        
        // usingSpringWithDamping:弹簧阻尼
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){// 如果是present
                self.present(listViewController)
            } else {// 如果是dismiss
                self.dismiss(listViewController)
            }
            
        }, completion: { finished in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screenViews.to.view)
            
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    // 设置到左上角
    func setToTopLeft(_ listViewController: ListViewController){
        
        listViewController.view.alpha = 0
        listViewController.view.transform = CGAffineTransform(translationX: -listViewController.view.bounds.width, y: -listViewController.view.bounds.height)
    }
    
    func present(_ listViewController: ListViewController){
        
        listViewController.view.alpha = 1
        listViewController.view.transform = CGAffineTransform.identity
    }
    
    func dismiss(_ listViewController: ListViewController){
        
        listViewController.view.alpha = 0
        listViewController.view.transform = CGAffineTransform(translationX: listViewController.view.bounds.width, y: listViewController.view.bounds.height)
    }
    
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
