import UIKit
import Fashion

enum Style: String, StringConvertible {

  case contentView, cardView

  var string: String {
    return rawValue
  }
}
