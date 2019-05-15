//
//  fullRawCell.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/15/19.
//

import UIKit
import Kingfisher

class fullRawCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func displayData(title: String, average: String, date: String, posterImage: String){
        self.title.text = title
        self.average.text = average
        self.date.text = date
        self.posterImage.kf.indicatorType = .activity
        self.posterImage.kf.setImage(with: URL(string: posterImage), placeholder: #imageLiteral(resourceName: "placeholder"))
    }

}
