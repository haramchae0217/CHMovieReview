//
//  SearchTableViewCell.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchCell"
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var rate: UILabel!
    
}
