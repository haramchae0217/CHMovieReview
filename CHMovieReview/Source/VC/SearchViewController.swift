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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        filteredMovie = MyDB.movieList
        
        tableViewSet()
        searchBarSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTableView.reloadData()
    }

    func tableViewSet() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    func searchBarSet() {
        let searchMovie = UISearchController(searchResultsController: nil)
        searchMovie.searchResultsUpdater = self
        searchMovie.searchBar.delegate = self
        searchMovie.searchBar.placeholder = "영화 제목을 검색하세요."
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchMovie
    }
    
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        if !filteredMovie.isEmpty {
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovie.count
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        let detailCell = filteredMovie[indexPath.row]
        detailVC.detailMovie = detailCell        
        detailVC.modalPresentationStyle = .overCurrentContext
        self.present(detailVC, animated: true)
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let movieTitle = searchController.searchBar.text {
//            filteredMovie = MyDB.movieList.filter{ $0.title.lowercased().contains(movieTitle) }
            movieTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        filteredMovie = MyDB.movieList
        movieTableView.reloadData()
    }
}
