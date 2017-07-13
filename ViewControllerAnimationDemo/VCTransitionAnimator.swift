//
//  VCTransitionAnimator.swift
//  ViewControllerAnimationDemo
//
//  Created by Kaibo Lu on 2017/7/12.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class VCTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var presenting: Bool = true // false means dismissing
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Get container view
        let containerView: UIView = transitionContext.containerView
        
        // Get view controllers
        let fromVC: UIViewController = transitionContext.viewController(forKey: .from)!
        let toVC: UIViewController = transitionContext.viewController(forKey: .to)!
        
        // Get views
        // View controller "modalPresentationStyle" property should not be .overFullScreen or .overCurrentContext, because "from" or "to" view may be nil
        let fromView: UIView = transitionContext.view(forKey: .from)!
        let toView: UIView = transitionContext.view(forKey: .to)!
        
        // Get frames
        let fromStartFrame: CGRect = transitionContext.initialFrame(for: fromVC)
        var fromFinalFrame: CGRect = fromStartFrame
        
        let toFinalFrame: CGRect = transitionContext.finalFrame(for: toVC)
        var toStartFrame: CGRect = toFinalFrame
        
        if presenting {
            fromFinalFrame.origin.x += fromFinalFrame.width
            
            toStartFrame.origin.x -= toStartFrame.width
            toView.frame = toStartFrame
            // Always add "to" view to container
            containerView.addSubview(toView)
            
        } else {
            fromFinalFrame.origin.x -= fromFinalFrame.width
            
            toStartFrame.origin.x += toStartFrame.width
            toView.frame = toStartFrame
            // Always add "to" view to container
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        // Animate using the animator's own duration value
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.frame = fromFinalFrame
            toView.frame = toFinalFrame
            
        }, completion: { (_) in
            // Notify UIKit that the transition has finished
            let complete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(complete)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }

}
