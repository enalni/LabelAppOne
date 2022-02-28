//
//  CustomCollectionViewCell.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 11.02.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    static let identifier = "CustomCollectionViewCell"
    
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - добавляем элементы в item
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Настраиваем расположение
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 1,
                                 y: 1,
                                 width: contentView.frame.size.width - 3,
                                 height: contentView.frame.size.height - 3)
    }
    
    //MARK: Переопредление ячейки
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.backgroundColor = nil
    }
    
    func loadImages(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print("Ошибка: \(error)")
            } else if let data = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
