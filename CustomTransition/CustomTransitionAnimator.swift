//
//  CustomTransitionAnimator.swift
//  CustomTransition
//
//  Created by Becarefullee on 16/10/24.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import UIKit



protocol CustomTransitionAnimatable {
  var morphViews: [UIView] { get }
  var animatableViews: [UIView] { get }
}


class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  fileprivate let duration = 0.4
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
    let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
    let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
    let container = transitionContext.containerView
    container.addSubview(toView)
    toView.frame = transitionContext.finalFrame(for: toController)
    toView.layoutIfNeeded()
    
    let canvas = UIView(frame: container.bounds)
    canvas.backgroundColor = toView.backgroundColor
    container.addSubview(canvas)

    let fromAnimatable = fromController as! CustomTransitionAnimatable
    let toAnimatable = toController as! CustomTransitionAnimatable
    let outgoingSnapshots = canvas.snapshotViews(fromAnimatable.animatableViews, afterUpdates: false)
    let incomingSnapshots = canvas.snapshotViews(toAnimatable.animatableViews, afterUpdates: true)
//    }
    print(outgoingSnapshots.count)

    let scaleTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    for view in incomingSnapshots {
      view.transform = scaleTransform
      view.alpha = 0
    }
    
    UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
        for view in outgoingSnapshots {
          view.transform = scaleTransform
          view.alpha = 0
        }
      }
      
      UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
        for view in incomingSnapshots {
          view.transform = CGAffineTransform.identity
          view.alpha = 1.0
        }
      }
      }, completion: { _ in
        canvas.removeFromSuperview()
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    animateMorphViews(Array(zip(fromAnimatable.morphViews, toAnimatable.morphViews)), canvas: canvas)
  }
  
  func animateMorphFromView(_ view: UIView, toView: UIView, canvas: UIView) {
    let fromView = canvas.snapshotView(view, afterUpdates: false)
    let toView = canvas.snapshotView(toView, afterUpdates: true)
    
    let targetCenter = toView.center
    toView.alpha = 0
    toView.transform = fromView.scaleTransformToView(toView)
    toView.center = fromView.center
    
    
    
    UIView.animate(withDuration: duration) {
      fromView.alpha = 1
      fromView.transform = toView.transform.inverted()
      fromView.center = targetCenter
      
      toView.alpha = 1
      toView.transform = CGAffineTransform.identity
      toView.center = targetCenter
    }
  }
  
  func animateMorphViews(_ views: [(UIView, UIView)], canvas: UIView) {
    views.forEach { animateMorphFromView($0.0, toView: $0.1, canvas: canvas) }
  }
}
