#if canImport(UIKit)
import XCTest
import UIKit
@testable import Fashion

final class StylesheetTests: XCTestCase {
  var stylesheet: Stylesheet!
  let style = "red-button"

  override func setUp() {
    super.setUp()
    stylesheet = TestEmptyStylesheet()
  }

  override func tearDown() {
    Stylist.master.styles.removeAll()
    Stylist.master.sharedStyles.removeAll()
    super.tearDown()
  }

  func testRegister() {
    stylesheet.register(style, stylization: { (button: UIButton) in
      button.backgroundColor = UIColor.red
    })

    // It registers stylization closure with a specified style name
    XCTAssertNotNil(Stylist.master.styles[style])
  }

  func testRegisterMultiple() {
    stylesheet.register(style) { (button: UIButton) in
      button.backgroundColor = UIColor.red
    }

    stylesheet.register(style) { (button: UIButton) in
      button.tintColor = UIColor.red
    }

    let button = UIButton()
    button.backgroundColor = .blue
    button.tintColor = .blue
    button.apply(styles: style)

    // It applies multiple register closures
    XCTAssertTrue(button.backgroundColor == .red)
    XCTAssertTrue(button.tintColor == .red)
  }

  func testUnregister() {
    stylesheet.register(style, stylization: { (button: UIButton) in
      button.backgroundColor = UIColor.red
    })

    XCTAssertNotNil(Stylist.master.styles[style])

    stylesheet.unregister(style)

    // It unregisters stylization closure
    XCTAssertNil(Stylist.master.styles[style])
  }

  func testShare() {
    stylesheet.share { (button: UIButton) in
      button.backgroundColor = UIColor.red
    }

    // It registers shared stylization closure for the specified type
    XCTAssertNotNil(Stylist.master.sharedStyles["UIButton"])
  }

  func testUnshare() {
    stylesheet.share { (button: UIButton) in
      button.backgroundColor = UIColor.red
    }

    XCTAssertNotNil(Stylist.master.sharedStyles["UIButton"])
    stylesheet.unshare(UIButton.self)

    // It unregisters shared stylization closure for the specified type
    XCTAssertNil(Stylist.master.sharedStyles["UIButton"])
  }

  func testClear() {
    stylesheet.share { (button: UILabel) in
      button.backgroundColor = UIColor.red
    }

    stylesheet.register(style) { (button: UIButton) in
      button.backgroundColor = UIColor.red
    }

    Stylist.master.clear()
    let button = UIButton()
    button.backgroundColor = .blue
    button.apply(styles: style)
    let label = UILabel()
    label.backgroundColor = .blue
    label.apply(styles: style)

    // It clears registered and shared styles
    XCTAssertFalse(button.backgroundColor == .red)
    XCTAssertFalse(label.backgroundColor == .red)
    XCTAssertTrue(Stylist.master.styles[style] == nil || Stylist.master.styles[style]?.count == 0)
  }
}
#endif
