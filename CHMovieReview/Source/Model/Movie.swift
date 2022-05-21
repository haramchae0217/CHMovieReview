//
//  Movie.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/21.
//

import UIKit

struct Movie {
    var poster: UIImage
    var title: String
    var director: String
    var actors: [String]
    var rate: String = "평가 기록이 없음."
    
    static var movieItem: [Movie] = [
        Movie(poster: UIImage(named: "movie1")!, title: "베놈2", director: "앤디 서키스", actors: ["톰 홀랜드","톰 하디"]),
        Movie(poster: UIImage(named: "movie2")!, title: "닥터스트레인지2", director: "샘 레이미", actors: ["소치 고메즈","베네딕트 컴버배치"]),
        Movie(poster: UIImage(named: "movie3")!, title: "그녀", director: "스파이크 존즈", actors: ["호아킨 피닉스","스칼렛 요한슨"]),
        Movie(poster: UIImage(named: "movie4")!, title: "기생충", director: "봉준호", actors: ["조여정","최우식"])
    ]
}
