//
//  MainScreenVC.swift
//  TheMovieDB2
//
//  Created by burak ozen on 16.03.2022.
//

import UIKit
import Alamofire
import Kingfisher

class MainScreenVC: UIViewController {

    @IBOutlet weak var movieTblView: UITableView!
    
    var movieResponse: MovieResponse?
    var detailMovie: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTblView.delegate = self
        movieTblView.dataSource = self
        
        Network.getMovieData { response in
            self.movieResponse = response
            self.movieTblView.reloadData()
        } errorHandler: { error in
            print("error")
        }
    }


}

extension MainScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = movieResponse?.results?.count else {
            return 0
        }
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = movieTblView.dequeueReusableCell(withIdentifier: "BigMovieScreenTableViewCell", for: indexPath) as! BigMovieScreenTableViewCell
            cell.delegate = self
            cell.setData(movieResponse: movieResponse!)
            
            return cell
            
        }
        
        let row = indexPath.row - 1
        
        //        api
        let cell = movieTblView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.movieTitleLabel.text = movieResponse?.results?[row].originalTitle
        cell.movieExplainLabel.text = movieResponse?.results?[row].overview
        cell.movieTimeLabel.text = movieResponse?.results?[row].releaseDate
        
        //        kingfisher
        let media = movieResponse?.results?[row]
        let str = "https://image.tmdb.org/t/p/w500\(media?.posterPath ?? "")"
        cell.movieImageView.kf.setImage(with: URL(string: str), placeholder: nil, options: nil, completionHandler: nil)
        
        return cell
    }
    
    //    details VC data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetailsScreenVC" {
            let vc = segue.destination as! MovieDetailScreenVC
            vc.movie = detailMovie
            
            
        } else {
            
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 {
            
            self.detailMovie = movieResponse?.results?[indexPath.row - 1 ]
            performSegue(withIdentifier: "toMovieDetailsScreenVC", sender: self)
            
        }
    
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Interaction
        print("cell with path: \(indexPath.row - 1)")
    }
    
    
    
}

extension MainScreenVC: BigScreenDelegate {
    func selectedMovie(result: Result) {
        
        self.detailMovie = result
        performSegue(withIdentifier: "toMovieDetailsScreenVC", sender: self)
    }
    
    
    
    
}
