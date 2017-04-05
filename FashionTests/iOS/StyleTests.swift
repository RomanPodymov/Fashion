import XCTest
@testable import Fashion

class StyleTests: XCTestCase {

  var style: Style<UILabel>!

  override func setUp() {
    super.setUp()
    style = Style<UILabel>{ label in
      label.backgroundColor = UIColor.white
      label.textColor = UIColor.red
      label.numberOfLines = 10
    }
  }

  override func tearDown() {
    super.tearDown()
    Stylist.master.styles.removeAll()
    Stylist.master.sharedStyles.removeAll()
  }

  func testApplyTo() {
    let label = UILabel()
    label.backgroundColor = UIColor.red
    label.textColor = UIColor.white
    label.numberOfLines = 2

    style.apply(to: label)

    // It applies the style to the passed model
    XCTAssertEqual(label.backgroundColor, UIColor.white)
    XCTAssertEqual(label.textColor, UIColor.red)
    XCTAssertEqual(label.numberOfLines, 10)
  }

  func testApplyToMultipleViews() {
    let label1 = UILabel()
    label1.backgroundColor = UIColor.red
    label1.textColor = UIColor.white
    label1.numberOfLines = 2

    let label2 = UILabel()
    label2.backgroundColor = UIColor.gray
    label2.textColor = UIColor.black
    label2.numberOfLines = 3

    style.apply(to: label1, label2)

    // It applies the style to the passed model
    XCTAssertEqual(label1.backgroundColor, UIColor.white)
    XCTAssertEqual(label1.textColor, UIColor.red)
    XCTAssertEqual(label1.numberOfLines, 10)

    XCTAssertEqual(label2.backgroundColor, UIColor.white)
    XCTAssertEqual(label2.textColor, UIColor.red)
    XCTAssertEqual(label2.numberOfLines, 10)
  }

  func testApplyToWithWrongModelType() {
    let view = UIView()
    view.backgroundColor = UIColor.red

    style.apply(to: view)

    // It does not apply the style to the passed model
    XCTAssertEqual(view.backgroundColor, UIColor.red)
  }
}
