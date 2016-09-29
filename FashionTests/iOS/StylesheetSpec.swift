import Quick
import Nimble
@testable import Fashion

class StylesheetSpec: QuickSpec {

  override func spec() {
    describe("Stylesheet") {
      let stylesheet = TestEmptyStylesheet()
      let style = "red-button"

      beforeEach {
        Stylist.master.styles.removeAll()
        Stylist.master.sharedStyles.removeAll()
      }

      describe("#register") {
        it("registers stylization closure with a specified style name") {
          stylesheet.register(style, stylization: { (button: UIButton) in
            button.backgroundColor = UIColor.red
          })

          expect(Stylist.master.styles[style]).toNot(beNil())
        }
      }

      describe("#unregister") {
        it("unregisters stylization closure") {
          stylesheet.register(style, stylization: { (button: UIButton) in
            button.backgroundColor = UIColor.red
          })

          expect(Stylist.master.styles[style]).toNot(beNil())

          stylesheet.unregister(style)

          expect(Stylist.master.styles[style]).to(beNil())
        }
      }

      describe("#share") {
        it("registers shared stylization closure for the specified type") {
          stylesheet.share { (button: UIButton) in
            button.backgroundColor = UIColor.red
          }

          expect(Stylist.master.sharedStyles["UIButton"]).toNot(beNil())
        }
      }

      describe("#unshare") {
        it("unregisters shared stylization closure for the specified type") {
          stylesheet.share { (button: UIButton) in
            button.backgroundColor = UIColor.red
          }

          expect(Stylist.master.sharedStyles["UIButton"]).toNot(beNil())

          stylesheet.unshare(UIButton.self)

          expect(Stylist.master.sharedStyles["UIButton"]).to(beNil())
        }
      }
    }
  }
}
