//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit
import Kingfisher

class MovieDetails: UIViewController {
    // MARK: - outlets
    @IBOutlet weak var bacGImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overView: UILabel!
    
    // MARK: - variables
    var movie : Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterImage.kf.indicatorType = .activity
        posterImage.kf.setImage(with: URL(string: movie.posterPath), placeholder: #imageLiteral(resourceName: "placeholder"))
        bacGImage.kf.indicatorType = .activity
        bacGImage.kf.setImage(with: URL(string: movie.backdropPath), placeholder: #imageLiteral(resourceName: "placeholder"))
        titleText.text = movie.title
        average.text = "\(movie.voteAverage ?? 0)"
        date.text = movie.releaseDate
        overView.text = movie.overview
    }
    
    // MARK: - buttons Action
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
