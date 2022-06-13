//
//  MovieInfoApi.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/06/14.
//

import Foundation

struct MovieApi {
    let movieUrl: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=a1ed7e8545b60db92d1bd8fced7532bc&language=ko&page=1&region=KR"

    func MovieApiSet(completion: @escaping (Results?, Int) -> Void) {
        let url: URL = URL(string: movieUrl)!
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            guard error == nil else {
                completion(nil, response.statusCode)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieInfo = try decoder.decode(Results.self, from: data)
                completion(movieInfo, response.statusCode)
            } catch {
                completion(nil, response.statusCode)
            }
        }
        dataTask.resume()
    }
}
