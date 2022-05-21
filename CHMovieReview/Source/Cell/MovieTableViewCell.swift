//
//  MovieTableViewCell.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieCell"
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var rate: UILabel!
    
}
