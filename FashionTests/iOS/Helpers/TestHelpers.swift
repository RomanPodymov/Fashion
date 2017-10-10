import UIKit
@testable import Fashion

final class TestEmptyStylesheet: Stylesheet {
  func define() {}
}

final class TestStylesheet: Stylesheet {
  let style = "red-button"

  init() {}

  func define() {
    register(style, stylization: { (button: UIButton) in
      button.backgroundColor = UIColor.red
    })
  }
}

final class Button: UIButton {
  override var backgroundColor: UIColor? {
    didSet {
    }
  }
}
