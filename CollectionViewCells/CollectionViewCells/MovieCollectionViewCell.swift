//
//  MovieCollectionViewCell.swift
//  CollectionViewCells
//
//  Created by Apzzo Technologies Private Limited on 06/04/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitlelabel: UILabel!
    
    func setup(with movies: Movies) {
        movieImageView.image = movies.image
        movieTitlelabel.text = movies.movieTitle
    }
}
