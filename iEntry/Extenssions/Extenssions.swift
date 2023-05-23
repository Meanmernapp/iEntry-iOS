//
//  Extenssions.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields
extension UIView {
    
    
    
    func roundViiew() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    func VerificationcodeViews() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4391649365, green: 0.4392448664, blue: 0.4391598701, alpha: 1)
    }
    func roundViewWithCustomRadius(radius:Int) {
        self.layer.cornerRadius = CGFloat(radius)
        
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            if #available(iOS 11.0, *) {
                clipsToBounds = true
                layer.cornerRadius = radius
                layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
            } else {
                let path = UIBezierPath(
                    roundedRect: bounds,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                )
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                layer.mask = mask
            }
        }
    
    
    func shadowAndRoundcorner(cornerRadius:Float,shadowColor:CGColor,shadowRadius:Float,shadowOpacity:Float) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = shadowColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.masksToBounds = false
    }
    
}


extension UIButton {
    func roundButton() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    func roundButtonWithCustomRadius(radius:Int) {
        self.layer.cornerRadius = CGFloat(radius)
        
    }
}


extension UIImageView {
    func roundImageWithCustomRadius(radius:Int) {
        self.layer.cornerRadius = CGFloat(radius)
        
    }
}


extension UIViewController {
    
    func navigationBarHidShow(isTrue:Bool) {
        self.navigationController?.navigationBar.isHidden = isTrue
    }
    
    
}


extension UITextField{

    func setPlaceHolderColor(color:UIColor){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}

enum UIColorHex: String {
    case firstGredient = "#00B2FF"
    case secondGredient = "#005DFF"
}

extension UIColor {
    static var appColor: UIColor {
        return UIColor(red: 125/255.0, green: 157/255.0, blue: 21/255.0, alpha: 1)
    }
    convenience init(hexString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension String {
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    var isValidEmail: Bool {
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
}

extension StringProtocol  {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}



@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UserDefaults {

   func save<T:Encodable>(customObject object: T, inKey key: String) {
       let encoder = JSONEncoder()
       if let encoded = try? encoder.encode(object) {
           self.set(encoded, forKey: key)
       }
   }

   func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
       if let data = self.data(forKey: key) {
           let decoder = JSONDecoder()
           if let object = try? decoder.decode(type, from: data) {
               return object
           }else {
               print("Couldnt decode object")
               return nil
           }
       }else {
           print("Couldnt find key")
           return nil
       }
   }

}

var  myDefaultLanguage  = lang.en
extension String {
    
    var localized: String {
         print("abc")
        let path = Bundle.main.path(forResource: myDefaultLanguage.rawValue, ofType: "lproj")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
extension Array {
     func contains<T>(obj: T) -> Bool where T: Equatable {
         return !self.filter({$0 as? T == obj}).isEmpty
     }
 }


extension Date {

    func startOfDay() -> Date?
    {
        let calendar = Calendar.current

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.minute = 0
        components.second = 0
        components.hour = 0

        return calendar.date(from: components)
    }

}

extension UIViewController {
    func addChildViewControllerWithView(_ childViewController: UIViewController, toView view: UIView? = nil) {
        let view: UIView = view ?? self.view
        childViewController.removeFromParent()
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childViewController.view)
        view.addConstraints([
            NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        view.layoutIfNeeded()
    }

    func removeChildViewController(_ childViewController: UIViewController) {
        childViewController.removeFromParent()
        childViewController.willMove(toParent: nil)
        childViewController.removeFromParent()
        childViewController.didMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        view.layoutIfNeeded()
    }
}



@IBDesignable class GradientView: UIView {

    @IBInspectable var startColor: UIColor = .blue {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var endColor: UIColor = .green {
        didSet {
            setNeedsLayout()
        }
    }

    

    @IBInspectable var shadowX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var shadowY: CGFloat = -3 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var shadowBlur: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var startPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var startPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var endPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var endPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }


    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        layer.shadowRadius = shadowBlur
        layer.shadowOpacity = 1
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        self.register(UINib(nibName: String(describing: T.self), bundle: .main), forCellReuseIdentifier: String(describing: T.self))
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        self.register(UINib(nibName: String(describing: T.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: T.self))
        let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
        return cell
    }
}

extension UICollectionView {
    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.visibleCells {
            let indexPath = self.indexPath(for: cell)
            return indexPath
        }
        
        return nil
    }
}



@IBDesignable
class CornerView: UIView {
    
    @IBInspectable var leftTopRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    @IBInspectable var rightTopRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    @IBInspectable var rightBottomRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    
    @IBInspectable var leftBottomRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyMask()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    /*override func draw(_ rect: CGRect) {
        super.draw(rect)

    }*/
    
    func applyMask()
    {
        let shapeLayer = CAShapeLayer(layer: self.layer)
        shapeLayer.path = self.pathForCornersRounded(rect:self.bounds).cgPath
        shapeLayer.frame = self.bounds
        shapeLayer.masksToBounds = true
        self.layer.mask = shapeLayer
    }
    
    func pathForCornersRounded(rect:CGRect) ->UIBezierPath
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0 + leftTopRadius , y: 0))
        path.addLine(to: CGPoint(x: rect.size.width - rightTopRadius , y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width , y: rightTopRadius), controlPoint: CGPoint(x: rect.size.width, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width , y: rect.size.height - rightBottomRadius))
        path.addQuadCurve(to: CGPoint(x: rect.size.width - rightBottomRadius , y: rect.size.height), controlPoint: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addLine(to: CGPoint(x: leftBottomRadius , y: rect.size.height))
        path.addQuadCurve(to: CGPoint(x: 0 , y: rect.size.height - leftBottomRadius), controlPoint: CGPoint(x: 0, y: rect.size.height))
        path.addLine(to: CGPoint(x: 0 , y: leftTopRadius))
        path.addQuadCurve(to: CGPoint(x: 0 + leftTopRadius , y: 0), controlPoint: CGPoint(x: 0, y: 0))
        path.close()
        
        return path
    }
    
}
