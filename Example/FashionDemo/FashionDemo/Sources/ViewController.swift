import UIKit
import Fashion

final class ViewController: UIViewController {
  lazy var cardView = UIView(styles: [Style.contentView, Style.cardView])
  
  lazy var label: UILabel = {
    let label = UILabel()
    label.text = "Fashion accessories and beauty tools to share and reuse UI styles in a Swifty way"
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Fashion"    
    view.apply(styles: Style.contentView)
    
    view.addSubview(cardView)
    cardView.addSubview(label)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    cardView.frame = CGRect(x: 15, y: 15, width: view.frame.width - 30, height: view.frame.height - 30)
    label.frame = CGRect(x: 10, y: 60, width: cardView.frame.width - 20, height: 100)
  }
}

