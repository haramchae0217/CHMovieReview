//
//  SearchViewController.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/19.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyDB.filteredMovie = MyDB.movieItem
        
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
        if !MyDB.filteredMovie.isEmpty {
            let movieCell = MyDB.filteredMovie[indexPath.row]
            var actors: String = ""
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
        return MyDB.filteredMovie.count
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        let detailCell = MyDB.filteredMovie[indexPath.row]
        detailVC.detailMovie = detailCell        
        detailVC.modalPresentationStyle = .overCurrentContext
        self.present(detailVC, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let movieTitle = searchController.searchBar.text {
            MyDB.filteredMovie = MyDB.movieItem.filter{ $0.title.lowercased().contains(movieTitle)}
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        MyDB.filteredMovie = MyDB.movieItem
        movieTableView.reloadData()
    }
}
