//
//  ExtensionCollectionViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 11.02.2022.
//

import Foundation
import UIKit

extension CollectionMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        picters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        DispatchQueue.main.async {
            cell.loadImages(from: self.picters[indexPath.row].urls.regularUrl)
        }
        return cell
    }
    
    
}
