//
//  CollectionMainViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 28.02.2022.
//

import UIKit

class CollectionMainViewController: UIViewController {

    private var collectionView: UICollectionView?
    var picters = [ImageInfo]()
    
    private var fetchNewImages: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetch()
        setupNavButton()
    }
    
    private func setupCollectionView() {
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        layot.minimumLineSpacing = 1
        layot.minimumInteritemSpacing = 1
        layot.itemSize = CGSize(width: (view.frame.size.width/3) - 4,
                                height: (view.frame.size.width/3) - 4)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        
        guard let collection = collectionView else {return}
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.frame = view.bounds
    }
    
    private func fetch() {
        let url = "https://api.unsplash.com/photos/random/?client_id=GsyXl5M4h9JHpZD5zonbKhlMoADacmcMPOsNWwU79e0&order_by=ORDER&count=30"
        guard let url = URL(string: url) else {return}
                URLSession.shared.dataTask(with: url) { data, responce, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let responce = responce as? HTTPURLResponse, let data = data {
                        print("Статус код: \(responce.statusCode)")
                        do {
                            let decoder = JSONDecoder()
                            let pic = try decoder.decode([ImageInfo].self, from: data)
                            self.picters.append(contentsOf: pic)
                            DispatchQueue.main.async {
                                self.collectionView?.reloadData()
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }.resume()
    }
    
    


}

extension CollectionMainViewController {
    
     func setupNavButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImages))
        fetchNewImages.addTarget(self, action: #selector(addImages), for: .touchUpInside)
    }
    
    @objc func addImages() {
        DispatchQueue.main.async {
            self.fetch()
        }
    }
}
