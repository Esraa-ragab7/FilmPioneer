//
//  fullRawCell.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/15/19.
//

import UIKit
import Kingfisher

class FullRawCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var average: UILabel!
    @IBOutlet private weak var date: UILabel!
    
    // MARK: - Functions
    
    func configureCell(title: String, average: String, date: String, posterImage: String){
        self.title.text = title
        self.average.text = average
        self.date.text = date
        self.posterImage.kf.indicatorType = .activity
        self.posterImage.kf.setImage(with: URL(string: posterImage), placeholder: #imageLiteral(resourceName: "placeholder"))
    }
    
}
