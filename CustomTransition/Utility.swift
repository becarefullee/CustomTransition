//
//  Utility.swift
//  CustomTransition
//
//  Created by Becarefullee on 16/10/24.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import UIKit

// Snapshot utilities
extension UIView {
  
  func snapshotView(_ view: UIView, afterUpdates: Bool) -> UIView {
    let snapshot = view.snapshotView(afterScreenUpdates: afterUpdates)
    self.addSubview(snapshot!)
    snapshot?.frame = convert(view.bounds, from: view)
    return snapshot!
  }
  
  func snapshotViews(_ views: [UIView], afterUpdates: Bool) -> [UIView] {
    return views.map { snapshotView($0, afterUpdates: afterUpdates) }
  }
  
}

// Scaling utilities
extension UIView {
  
  func scaleTransformToView(_ toView: UIView) -> CGAffineTransform {
    return CGAffineTransform(
      scaleX: bounds.width / toView.bounds.width,
      y: bounds.height / toView.bounds.height)
  }
  
}
