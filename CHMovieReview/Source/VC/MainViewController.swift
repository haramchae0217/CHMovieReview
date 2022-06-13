//
//  ViewController.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/18.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    var nowPlayingMovie: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSet()
        appendMovie()
    }
    
    func tableViewSet() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    func appendMovie() {
        MovieApi().MovieApiSet { movie, code in
            if code == 200 {
                guard let movie = movie else { return }
                self.nowPlayingMovie = movie.results
            } else {
                print("검색 실패",code)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = nowPlayingMovie[indexPath.row]
//        let cast = MyDB.creditCastList[indexPath.row]
//        let crew = MyDB.creditCrewList[indexPath.row]
        let imageURL: URL = URL(string: movie.poster_path)!
        let imageData = try! Data(contentsOf: imageURL)
        
        cell.title.text = movie.title
        
//        cell.actors.text = cast.name
//        cell.director.text = crew.name
        
//        cell.rate.text = movie.rate
        cell.poster.image = UIImage(data: imageData)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlayingMovie.count
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        let movieInfo = nowPlayingMovie[indexPath.row]
        detailVC.detailMovie = movieInfo
        detailVC.modalPresentationStyle = .overCurrentContext
        self.present(detailVC, animated: true)
    }
}
