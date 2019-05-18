//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit
import Kingfisher
import ViewAnimator

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var bacGImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var ratesNum: UILabel!
    @IBOutlet weak var posterImageView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var rateView: UIView!
    
    // MARK: - Properties
    
    var movie : Results!
    private let zoomAnimation = AnimationType.zoom(scale: 0.2)
    private let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    private let fromRightmAnimation = AnimationType.from(direction: .right, offset: 250.0)
    private let fromBottomAnimation = AnimationType.from(direction: .bottom, offset: 250.0)
    
    // MARK: - ViewController Life Cycle
    
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
        ratesNum.text = "\(movie.voteCount ?? 0)"
        UIView.animate(views: [posterImageView],
                       animations: [rotateAnimation, zoomAnimation],
                       duration: 0.5)
        UIView.animate(views: [detailsView],
                       animations: [fromBottomAnimation],
                       duration: 0.5)
        UIView.animate(views: [rateView],
                       animations: [fromRightmAnimation],
                       duration: 0.5)
    }
    
    // MARK: - IBActions
    
    @IBAction private func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
