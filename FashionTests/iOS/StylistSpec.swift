import Quick
import Nimble
@testable import Fashion

class StylistSpec: QuickSpec {

  override func spec() {
    describe("Stylist") {
      var stylist: Stylist!

      beforeEach {
        Stylist.master.styles.removeAll()
        Stylist.master.sharedStyles.removeAll()

        stylist = Stylist()
      }

      // MARK: - Stylization

      describe("#apply:styles:model") {
        let styles = ["label-1", "label-2"]

        beforeEach {
          stylist.register("label-1") { (label: UILabel) in
            label.textColor = UIColor.red
            label.numberOfLines = 10
          }

          stylist.register("label-2") { (label: UILabel) in
            label.backgroundColor = UIColor.yellow
            label.numberOfLines = 3
          }
        }

        context("when the model is of expected type") {
          it("applies the styles to the passed model") {
            let label = UILabel()
            label.backgroundColor = UIColor.red
            label.textColor = UIColor.white
            label.numberOfLines = 2

            stylist.apply(styles, model: label)

            expect(label.backgroundColor).to(equal(UIColor.yellow))
            expect(label.textColor).to(equal(UIColor.red))
            expect(label.numberOfLines).to(equal(3))
          }
        }

        context("when the model is of different type") {
          it("does not apply the styles to the passed model") {
            let view = UIView()
            view.backgroundColor = UIColor.red

            stylist.apply(styles, model: view)

            expect(view.backgroundColor).to(equal(UIColor.red))
          }
        }
      }

      describe("#apply:style:model") {
        let style = "label-3"

        beforeEach {
          stylist.register("label-3") { (label: UILabel) in
            label.textColor = UIColor.red
            label.backgroundColor = UIColor.yellow
            label.numberOfLines = 10
          }
        }

        context("when the model is of expected type") {
          it("applies the styles to the passed model") {
            let label = UILabel()
            label.backgroundColor = UIColor.red
            label.textColor = UIColor.white
            label.numberOfLines = 2

            stylist.apply(style, model: label)

            expect(label.backgroundColor).to(equal(UIColor.yellow))
            expect(label.textColor).to(equal(UIColor.red))
            expect(label.numberOfLines).to(equal(10))
          }
        }

        context("when the model is of different type") {
          it("does not apply the styles to the passed model") {
            let view = UIView()
            view.backgroundColor = UIColor.red

            stylist.apply(style, model: view)

            expect(view.backgroundColor).to(equal(UIColor.red))
          }
        }
      }

      describe("#applyShared") {
        beforeEach {
          stylist.share { (label: UILabel) in
            label.textColor = UIColor.green
            label.layer.borderWidth = 2
          }

          stylist.share { (view: UIView) in
            view.backgroundColor = UIColor.yellow
            view.tintColor = UIColor.red
            view.layer.borderWidth = 3
          }
        }

        it("applies shared styles to the passed model") {
          let label = UILabel()

          stylist.applyShared(label)

          expect(label.backgroundColor).to(equal(UIColor.yellow))
          expect(label.tintColor).to(equal(UIColor.red))
          expect(label.textColor).to(equal(UIColor.green))
          expect(label.layer.borderWidth).to(equal(2))

          let textView = UITextView()
          stylist.applyShared(textView)

          expect(textView.backgroundColor).to(equal(UIColor.yellow))
          expect(textView.tintColor).to(equal(UIColor.red))
          expect(textView.textColor).to(beNil())
          expect(textView.layer.borderWidth).to(equal(3))

          let button = Button()
          stylist.applyShared(button)

          expect(button.backgroundColor).to(equal(UIColor.yellow))
          expect(button.tintColor).to(equal(UIColor.red))
          expect(button.layer.borderWidth).to(equal(3))
        }
      }

      // MARK: - StyleManaging

      describe("#register") {
        let style = "red-button"

        it("registers stylization closure with a specified style name") {
          stylist.register(style) { (button: UIButton) in
            button.backgroundColor = UIColor.red
          }

          expect(stylist.styles[style]).toNot(beNil())
        }
      }

      describe("#unregister") {
        let style = "red-button"

        it("unregisters stylization closure") {
          stylist.register(style) { (button: UIButton) in
            button.backgroundColor = UIColor.red
          }

          expect(stylist.styles[style]).toNot(beNil())

          stylist.unregister(style)

          expect(stylist.styles[style]).to(beNil())
        }
      }

      describe("#share") {
        it("registers shared stylization closure for the specified type") {
          stylist.share { (button: UIButton) in
            button.backgroundColor = UIColor.red
          }

          expect(stylist.sharedStyles["UIButton"]).toNot(beNil())
        }
      }

      describe("#unshare") {
        it("unregisters shared stylization closure for the specified type") {
          stylist.share { (button: UIButton) in
            button.backgroundColor = UIColor.red
          }

          expect(stylist.sharedStyles["UIButton"]).toNot(beNil())

          stylist.unshare(UIButton.self)

          expect(stylist.sharedStyles["UIButton"]).to(beNil())
        }
      }
    }
  }
}
