//
//  MovieResponse.swift
//  TheMovieDB2
//
//  Created by burak ozen on 17.03.2022.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    var page: Int?
    var results: [Result]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
