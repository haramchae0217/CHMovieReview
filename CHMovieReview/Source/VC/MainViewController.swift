//
//  ViewController.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/18.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    
    var movieID: [Int] = []
    var id: Int = 0
    let movieURL: URL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a1ed7e8545b60db92d1bd8fced7532bc&language=ko&page=1&region=KR")!
    
    var creditURL: URL = URL(string: "https://api.themoviedb.org/3/movie/619803/credits?api_key=a1ed7e8545b60db92d1bd8fced7532bc&language=ko")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendMovie()
        appendCredit()
        tableViewSet()
    }
    
    func tableViewSet() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    func appendMovie() {
        MovieApiSet { movieService, result in
            guard let movieService = movieService else {
                print("result : \(result)")
                return
            }
            MyDB.movieServiceList.append(movieService)
            for movie in MyDB.movieServiceList {
                print(movie.results)
                for movieInfo in movie.results {
                    MyDB.movieList.append(movieInfo)
                    self.movieID.append(movieInfo.id)
                }
            }
        }
    }
    
    func MovieApiSet(completion: @escaping (MovieService?, String) -> Void) {
        URLSession.shared.dataTask(with: movieURL) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let movieInfo = try decoder.decode(MovieService.self, from: data)
                completion(movieInfo, "데이터 통신 완료")
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume()
    }
    
    func appendCredit() {
        var count = 0
        creditApiSet { creditService, result in
            guard let creditService = creditService else {
                print("result : \(result)")
                return
            }
            MyDB.creditServiceList.append(creditService)
            for credit in MyDB.creditServiceList {
//                print(credit.cast)
//                print(credit.crew)
                for cast in credit.cast {
                    MyDB.creditCastList.append(cast)
                    count += 1
                    if count == 2 {
                        break
                    }
                }
                for crew in credit.crew {
                    if crew.department == "Directing" {
                        MyDB.creditCrewList.append(crew)
                        print(crew)
                    }
                }
            }
        }
    }
    
    func creditApiSet(completion: @escaping (CreditService?, String) -> Void) {
        URLSession.shared.dataTask(with: creditURL) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let creditInfo = try decoder.decode(CreditService.self, from: data)
                completion(creditInfo, "데이터 통신 완료")
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume()
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = MyDB.movieList[indexPath.row]
//        let cast = MyDB.creditCastList[indexPath.row]
//        let crew = MyDB.creditCrewList[indexPath.row]
//        let imageURL: URL = URL(string: movie.poster_path)!
//        let imageData = try! Data(contentsOf: imageURL)
        
        cell.title.text = movie.title
//        cell.actors.text = cast.name
//        cell.director.text = crew.name
        
//        cell.rate.text = movie.rate
//        cell.poster.image = UIImage(data: imageData)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyDB.movieList.count
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        let movieInfo = MyDB.movieList[indexPath.row]
        detailVC.detailMovie = movieInfo
        detailVC.modalPresentationStyle = .overCurrentContext
        self.present(detailVC, animated: true)
    }
}
