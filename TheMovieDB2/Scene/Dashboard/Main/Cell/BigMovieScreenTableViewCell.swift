//
//  BigMovieScreenTableViewCell.swift
//  TheMovieDB2
//
//  Created by burak ozen on 17.03.2022.
//

import UIKit


protocol BigScreenDelegate {
    func selectedMovie (result: Result)
        
    
}

class BigMovieScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var bigMovieScreenView: UIView!
    @IBOutlet weak var bigMovieCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var delegate: BigScreenDelegate?
    
    
    var movieResponse: MovieResponse?
    var detailMovie: Result?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bigMovieCollectionView.delegate = self
        bigMovieCollectionView.dataSource = self
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
//        let screenHeight = screenRect.size.height
        let layout = bigMovieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: ((screenWidth)), height: (250))
        
    }
    
    func setData(movieResponse: MovieResponse) {
        
        self.movieResponse = movieResponse
        self.pageController.numberOfPages = movieResponse.results?.count ?? 0
        bigMovieCollectionView.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}

extension BigMovieScreenTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieResponse?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        api
        let cell = bigMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "BigMovieScreenCollectionViewCell", for: indexPath) as! BigMovieScreenCollectionViewCell
                cell.bigMovieTitleLabel.text = movieResponse?.results?[indexPath.row].originalTitle
                cell.bigMovieExplainLabel.text = movieResponse?.results?[indexPath.row].overview
                
                
        //        kingfisher
                let media = movieResponse?.results?[indexPath.row]
                let str = "https://image.tmdb.org/t/p/w500\(media?.posterPath ?? "")"
                cell.bigMovieImageView.kf.setImage(with: URL(string: str), placeholder: nil, options: nil, completionHandler: nil)
                
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let result = movieResponse?.results?[indexPath.row] {
            delegate?.selectedMovie(result: result)

        }
        
        
    }
    
}
