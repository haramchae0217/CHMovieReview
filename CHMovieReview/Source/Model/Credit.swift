//
//  Credit.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/06/03.
//

import Foundation

struct CreditService: Decodable {
    var id: Int
    var cast: [CreditCast]
    var crew: [CreditCrew]
}

struct CreditCast: Decodable {
    var name: String
}

struct CreditCrew: Decodable {
    var name: String
    var department: String 
}
