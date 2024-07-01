//
//  CollectionViewCell.swift
//  ImageAdder
//
//  Created by Apzzo on 17/04/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var plusBtnV: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
