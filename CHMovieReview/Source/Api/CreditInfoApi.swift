//
//  CreditInfoApi.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/06/14.
//

import Foundation

struct CreditApi {
    let creditUrl: String = "https://api.themoviedb.org/3/movie/619803/credits?api_key=a1ed7e8545b60db92d1bd8fced7532bc&language=ko"
    
    func creditApiSet(completion: @escaping (CreditService?, Int) -> Void) {
        let url: URL = URL(string: creditUrl)!
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
                let creditInfo = try decoder.decode(CreditService.self, from: data)
                completion(creditInfo, response.statusCode)
            } catch {
                completion(nil, response.statusCode)
            }
        }
        dataTask.resume()
    }
}
