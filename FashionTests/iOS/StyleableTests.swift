import XCTest
import UIKit
@testable import Fashion

class StyleableTests: XCTestCase {

  override func tearDown() {
    Stylist.master.styles.removeAll()
    Stylist.master.sharedStyles.removeAll()
    super.tearDown()
  }

  func testStylize() {
    let label = UILabel()
    label.backgroundColor = UIColor.red
    label.textColor = UIColor.white
    label.numberOfLines = 2

    label.stylize({ label in
      label.backgroundColor = UIColor.white
      label.textColor = UIColor.blue
      label.numberOfLines = 10
    })
    
    // It applies a stylization closure
    XCTAssertEqual(label.backgroundColor, UIColor.white)
    XCTAssertEqual(label.textColor, UIColor.blue)
    XCTAssertEqual(label.numberOfLines, 10)
  }

  func testApplyStyle() {
    let label = UILabel()
    label.backgroundColor = UIColor.red
    label.textColor = UIColor.white
    label.numberOfLines = 2

    let style = Style<UILabel>{ label in
      label.backgroundColor = UIColor.white
      label.textColor = UIColor.blue
      label.numberOfLines = 10
    }

    label.apply(style: style)

    // It applies a stylization closure
    XCTAssertEqual(label.backgroundColor, UIColor.white)
    XCTAssertEqual(label.textColor, UIColor.blue)
    XCTAssertEqual(label.numberOfLines, 10)
  }
}
