//
//  ViewController.swift
//  CustomTransition
//
//  Created by Becarefullee on 16/10/24.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let collectionViewDataSource = [UIImage(named: "image")]
  fileprivate var selectedCell: DetailCollectionViewCell?
  
  @IBOutlet weak var imageCollectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    imageCollectionView.dataSource = self
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let cell = sender as? DetailCollectionViewCell,
    let path = imageCollectionView.indexPath(for: cell),
    let detailVC = segue.destination as? DetailViewController
      else {
      return
    }
    selectedCell = cell
    detailVC.image = collectionViewDataSource[(path as NSIndexPath).row]
  }

}

extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return collectionViewDataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! DetailCollectionViewCell
    cell.imageView.image = collectionViewDataSource[indexPath.row]
    return cell
  }
  
}


