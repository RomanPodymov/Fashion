#if os(macOS)
import Cocoa

extension NSView: Styleable {}

public extension NSView {
    private struct AssociatedKeys {
        static var Style: Void?
    }

    /**
     Applies previously registered styles.
     
     - Parameter styles: Set of style names.
     */
    func apply(styles: [StringConvertible]) {
        self.styles = styles.map { $0.string } .joined(separator: " ")
    }

    /**
     Applies previously registered styles.
     
     - Parameter styles: Set of style names.
     */
    func apply(styles: StringConvertible...) {
        apply(styles: styles.map { $0 })
    }

    /**
     Applies previously registered styles.
    
     - Parameter styles: Single style or multiple styles separated by whitespace.
     */
    @IBInspectable var styles: String? {
        get {
            withUnsafePointer(to: &AssociatedKeys.Style) {
                return objc_getAssociatedObject(self, $0) as? String
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
