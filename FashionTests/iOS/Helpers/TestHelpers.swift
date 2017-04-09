import UIKit
@testable import Fashion

struct TestEmptyStylesheet: Stylesheet {
  func define() {}
}

struct TestStylesheet: Stylesheet {

  let style = "red-button"

  init() {}

  func define() {
    register(style, stylization: { (button: UIButton) in
      button.backgroundColor = UIColor.red
    })
  }
}

class Button: UIButton {
  override var backgroundColor: UIColor? {
    didSet {
    }
  }
}
