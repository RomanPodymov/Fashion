import Quick
import Nimble
@testable import Fashion

class FashionSpec: QuickSpec {

  override func spec() {
    describe("Fashion") {
      let stylesheet = TestStylesheet()

      beforeEach {
        Stylist.master.styles.removeAll()
        Stylist.master.sharedStyles.removeAll()
      }

      describe("#register") {
        it("registers passed stylesheets") {
          Fashion.register(stylesheets: [stylesheet])

          expect(Stylist.master.styles[stylesheet.style]).toNot(beNil())
        }
      }
    }
  }
}
