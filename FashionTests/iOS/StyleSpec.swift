import Quick
import Nimble
@testable import Fashion

class StyleSpec: QuickSpec {

  override func spec() {
    describe("Style") {
      var style: Style<UILabel>!

      beforeEach {
        Stylist.master.styles.removeAll()
        Stylist.master.sharedStyles.removeAll()

        style = Style<UILabel>{ label in
          label.backgroundColor = UIColor.white
          label.textColor = UIColor.red
          label.numberOfLines = 10
        }
      }

      describe("#applyTo:model") {
        context("when the model is of expected type") {
          it("applies the style to the passed model") {
            let label = UILabel()
            label.backgroundColor = UIColor.red
            label.textColor = UIColor.white
            label.numberOfLines = 2

            style.applyTo(label)

            expect(label.backgroundColor).to(equal(UIColor.white))
            expect(label.textColor).to(equal(UIColor.red))
            expect(label.numberOfLines).to(equal(10))
          }
        }

        context("when the model is of different type") {
          it("does not apply the style to the passed model") {
            let view = UIView()
            view.backgroundColor = UIColor.red

            expect(view.backgroundColor).to(equal(UIColor.red))
          }
        }
      }
    }
  }
}
