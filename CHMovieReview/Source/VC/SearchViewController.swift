//
//  SearchViewController.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/19.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    var filteredMovie: [Movie] = []
    var actors: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredMovie = Movie.movieItem
        
        tableViewSet()
        searchBarSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filteredMovie = Movie.movieItem
        movieTableView.reloadData()
    }

    func tableViewSet() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    func searchBarSet() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "영화 제목을 검색하세요."
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        if !filteredMovie.isEmpty {
            let movieCell = filteredMovie[indexPath.row]
            for data in movieCell.actors {
                actors += "\(data), "
            }
            
            cell.poster.image = movieCell.poster
            cell.title.text = movieCell.title
            cell.director.text = "감독 : \(movieCell.director)"
            cell.actors.text = " 배우 : \(actors)"
            cell.rate.text = movieCell.rate
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovie.count
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filteredMovie = Movie.movieItem.filter{ $0.title.lowercased().contains(text)}
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredMovie = Movie.movieItem
        movieTableView.reloadData()
    }
}
