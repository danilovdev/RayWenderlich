
import UIKit

final class PhotoCell: UITableViewCell {
  
  var isLoading: Bool {
    get { return activityIndicator.isAnimating }
    set {
      if newValue {
        activityIndicator.startAnimating()
      } else {
        activityIndicator.stopAnimating()
      }
    }
  }
  
  @IBOutlet private weak var theImageView: UIImageView!
  
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  
  func display(image: UIImage?) {
    theImageView.image = image
  }
}

