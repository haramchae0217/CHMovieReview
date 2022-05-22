//
//  ReviewTableViewCell.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

  static let identifier = "ReviewCell"

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var rate: UILabel!
    
}
