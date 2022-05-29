//
//  AddReviewViewController.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/19.
//

import UIKit

class AddReviewViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var myReview: UITextView!
    @IBOutlet weak var limitText: UILabel!
    
    var movieInfo: Movie?
    var textCount: Int = 0
    var actor: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieInfo = movieInfo {
            for data in movieInfo.actors{
                actor += "\(data), "
            }
            poster.image = movieInfo.poster
            movieTitle.text = movieInfo.title
            director.text = "감독 : \(movieInfo.director)"
            actors.text = "배우 : \(actor)"
            rate.text = movieInfo.rate
            summary.text = movieInfo.summary
            limitText.text = "\(textCount) / 100자"
        }

    }

}
