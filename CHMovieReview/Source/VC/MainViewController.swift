//
//  ViewController.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/18.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSet()
        movieTableView.reloadData()
    }
    
    func tableViewSet() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }


}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movieCell = Movie.movieItem[indexPath.row]
        cell.poster.image = movieCell.poster
        cell.title.text = "\(movieCell.title)"
        cell.director.text = "감독 : \(movieCell.director)"
        cell.actors.text = " 배우 : \(movieCell.actors)"
        cell.rate.text = movieCell.rate
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.movieItem.count
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
