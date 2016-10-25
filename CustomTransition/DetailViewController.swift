//
//  DetailViewController.swift
//  CustomTransition
//
//  Created by Becarefullee on 16/10/24.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
  
  @IBOutlet weak var imageView: UIImageView!
}


extension DetailViewController: CustomTransitionAnimatable {
  var morphViews: [UIView] { return [imageView] }
  var animatableViews: [UIView] {return [imageView]}
  
}
