//
//  ModalTransitionDelegate.swift
//  Test modal
//
//  Created by Javier Loucim on 21/02/2019.
//  Copyright © 2019 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

protocol ModalTransitionPresenter {
    var transitionDelegate: ModalTransitionDelegate { get set }
}
extension ModalTransitionPresenter where Self: UIViewController {
    func presentModalWithCustomTransition(viewController: UIViewController) {
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self.transitionDelegate
        self.present(viewController, animated: true, completion: nil)
    }
}

class ModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPushAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPopAnimator()
    }
}

// MARK: - Animators

class ModalPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        toViewController.view.transform = CGAffineTransform(translationX: 0, y: toViewController.view.bounds.height)
        let overlayView = UIView.init(frame: toViewController.view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.24)
        overlayView.alpha = 0
        transitionContext.containerView.addSubview(overlayView)
        transitionContext.containerView.addSubview(toViewController.view)
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            overlayView.alpha = 1
            toViewController.view.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
class ModalPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from)
            else {
                return
        }
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            transitionContext.containerView.alpha = 0
            fromViewController.view.transform = CGAffineTransform(translationX: 0, y: fromViewController.view.bounds.height)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
