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
        
        

    }

}
