//
//  Movie.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/21.
//

import UIKit

struct Results: Decodable {
    var results: [Movie]
}

struct Movie: Decodable {
    var title: String
    var overview: String
    var poster_path: String
    var id: Int
}

