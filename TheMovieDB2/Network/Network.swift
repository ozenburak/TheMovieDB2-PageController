//
//  Network.swift
//  TheMovieDB2
//
//  Created by burak ozen on 16.03.2022.
//

import Foundation
import Alamofire
import Kingfisher

class Network{
    
    static func getMovieData(complationHandler:@escaping (MovieResponse)->(), errorHandler:@escaping (String)->()){
        AF.request("https://api.themoviedb.org/3/discover/movie?api_key=7e875d92283c6cec3ab612ba930d6edc&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate").responseDecodable { (response:AFDataResponse<MovieResponse>) in
            switch response.result{
                case .success(let movieResponse):
                complationHandler(movieResponse)
                case .failure(let error):
                errorHandler(error.localizedDescription)
                    print(error)
                break
            }
        }
    }
    
}
