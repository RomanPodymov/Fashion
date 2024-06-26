#if canImport(UIKit)
import UIKit

extension UIView {
  private struct AssociatedKeys {
    static var Style: Void?
  }

  public convenience init(frame: CGRect = CGRect.zero, styles: [StringConvertible]) {
    self.init(frame: frame)
    apply(styles: styles)
  }

  public convenience init(frame: CGRect = CGRect.zero, styles: StringConvertible) {
    self.init(frame: frame)
    apply(styles: styles)
  }

  /**
    Applies previously registered styles.

    - Parameter styles: Set of style names.
  */

  public func apply(styles: [StringConvertible]) {
    self.styles = styles.map { $0.string } .joined(separator: " ")
  }

  /**
   Applies previously registered styles.

   - Parameter styles: Set of style names.
   */

  public func apply(styles: StringConvertible...) {
    apply(styles: styles.map { $0 })
  }

  /**
   Inherits registered shared styles.
   */
  public func inheritStyles() {
    Stylist.master.applyShared(self)
  }

  /**
   Applies previously registered styles.

   - Parameter styles: Single style or multiple styles separated by whitespace.
   */
  @IBInspectable public var styles: String? {
    get {
      withUnsafePointer(to: &AssociatedKeys.Style) {
        objc_getAssociatedObject(self, $0) as? String
      }
    }
    set (newValue) {
      objc_setAssociatedObject(
        self,
        &AssociatedKeys.Style,
        newValue,
        objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )

      if let newValue = newValue {
        let styles = newValue.components(separatedBy: " ")
        Stylist.master.apply(styles, model: self)
      }
    }
  }
}
#endif
