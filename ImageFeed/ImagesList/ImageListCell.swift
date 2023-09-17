import UIKit

final class ImageListCell: UITableViewCell {
    static let reuseIdentifier = "ImageListCell"
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var gradientView: UIView!
    
    func setupGradient() {
        let gradient = CAGradientLayer()
        
        gradient.frame = gradientView.bounds
//        gradient.colors = [#1A1B2200, #1A1B22]
        gradient.colors = [UIColor.ypBlack.withAlphaComponent(0).cgColor, UIColor.ypBlack.withAlphaComponent(0.3).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    
}
