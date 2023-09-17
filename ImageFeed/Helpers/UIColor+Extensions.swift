import UIKit

extension UIColor {
    static var ypBlack: UIColor { UIColor(named: "YP Black") ?? UIColor.black }
    static var ypWhite: UIColor { UIColor(named: "YP White") ?? UIColor.white }
    static var ypBackground: UIColor { UIColor(named: "YP Background") ?? UIColor.black }
    static var ypRed: UIColor { UIColor(named: "YP Red") ?? UIColor.red }
    static var ypBlue: UIColor { UIColor(named: "YP Blue") ?? UIColor.blue }
    static var ypWhiteAlpha: UIColor { UIColor(named: "YP White Alpha") ?? UIColor.white.withAlphaComponent(50) }
    static var ypGray: UIColor { UIColor(named: "YP Gray") ?? UIColor.gray }
}
