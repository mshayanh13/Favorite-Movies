//
//  MovieCell.swift
//  Favorite Movies
//
//  Created by Mohammad Hemani on 4/19/17.
//  Copyright © 2017 Mohammad Hemani. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configureCell(movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.details
        urlLabel.text = movie.link
        movieImage.image = movie.toImage?.image as? UIImage
    }

}
