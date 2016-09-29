import Quick
import Nimble
@testable import Fashion

class StyleableSpec: QuickSpec {

  override func spec() {
    describe("Styleable") {
      var label: UILabel!

      beforeEach {
        Stylist.master.styles.removeAll()
        Stylist.master.sharedStyles.removeAll()

        label = UILabel()
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.numberOfLines = 2
      }

      describe("#stylize") {
        it("applies a stylization closure") {
          label.stylize({ label in
            label.backgroundColor = UIColor.white
            label.textColor = UIColor.blue
            label.numberOfLines = 10
          })

          expect(label.backgroundColor).to(equal(UIColor.white))
          expect(label.textColor).to(equal(UIColor.blue))
          expect(label.numberOfLines).to(equal(10))
        }
      }
    }
  }
}
