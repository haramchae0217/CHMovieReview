//
//  DetailViewController.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var summary: UILabel!
    
    var detailMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detailMovie = detailMovie {
            movieTitle.text = detailMovie.title
            poster.image = detailMovie.poster
            summary.text = detailMovie.summary
        }
    }

    @IBAction func addReviewButton(_ sender: UIButton) {
        guard let addReviewVC = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVC") as? AddReviewViewController else { return }
        addReviewVC.movieInfo = detailMovie
        self.navigationController?.pushViewController(addReviewVC, animated: true)
    }
    
    @IBAction func closeDetailVC(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
