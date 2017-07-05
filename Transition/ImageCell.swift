//
//  ImageCell.swift
//  Transition
//
//  Created by CJ on 2017/7/5.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    var imageName:String? {
        didSet{
            if let imageName = imageName {
                imageView.image = UIImage.init(named: imageName)
            }
        }
    }
}
