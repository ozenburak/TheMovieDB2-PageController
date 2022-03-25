//
//  MovieDetailScreenVC.swift
//  TheMovieDB2
//
//  Created by burak ozen on 16.03.2022.
//

import UIKit

class MovieDetailScreenVC: UIViewController {

    @IBOutlet weak var detailMovieImageView: UIImageView!
    @IBOutlet weak var imdbImageView: UIImageView!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var moviePointLabel: UILabel!
    @IBOutlet weak var dotImageView: UIImageView!
    @IBOutlet weak var detailMovieTimeLabel: UILabel!
    @IBOutlet weak var detailMovieTitleLabel: UILabel!
    @IBOutlet weak var detailMovieExplainTextView: UITextView!
    
    var movie: Result? 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.detailMovieTitleLabel.text = movie?.originalTitle
        self.moviePointLabel.text = "\(movie?.voteAverage ?? 0.0)"
        self.detailMovieTimeLabel.text = movie?.releaseDate
        self.detailMovieExplainTextView.text = movie?.overview
        
        let str="https://image.tmdb.org/t/p/w500\(movie?.backdropPath ?? "")"
        self.detailMovieImageView.kf.setImage(with: URL(string: str), placeholder: nil, options: nil, completionHandler: nil)
    }
    

    

}
