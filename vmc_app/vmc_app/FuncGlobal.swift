//
//  FuncGlobal.swift
//  vmc_app
//
//  Created by macbook3 on 7/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

extension String {

    //let count = micadena.length
    var length: Int { return characters.count }
    
    //stringConEpacios.convertirEspaciosGet()
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    func convertirEspaciosGet() -> String {
        return self.replace(" ", replacement: "%20")
    }
    
}

extension UILabel {
    // cambia tamaño de altura dinamicamente UILabel
    func resizeHeightToFit(heightConstraint: NSLayoutConstraint) {
        let attributes = [NSFontAttributeName : font]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.ByWordWrapping
        let rect = text!.boundingRectWithSize(CGSizeMake(frame.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        heightConstraint.constant = rect.height
        setNeedsLayout()
    }
    
    //cambia el tamaño de fuente
    func setSizeFont(sizeFont: CGFloat) -> UIFont {
        self.sizeToFit()
        return  UIFont(name: self.font.fontName, size: sizeFont)!
        
    }
    
 

    //myLabel.setSizeFont(60)
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.Top:
            border.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), thickness)
            break
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, UIScreen.mainScreen().bounds.width, thickness)
            break
        case UIRectEdge.Left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.Right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }
        
        border.backgroundColor = color.CGColor;
        
        self.addSublayer(border)
    }
    
}

extension UIColor {
    convenience init(hexaString:String) {
        self.init(
            red:   CGFloat( strtoul( String(Array(hexaString.characters)[1...2]), nil, 16) ) / 255.0,
            green: CGFloat( strtoul( String(Array(hexaString.characters)[3...4]), nil, 16) ) / 255.0,
            blue:  CGFloat( strtoul( String(Array(hexaString.characters)[5...6]), nil, 16) ) / 255.0, alpha: 1 )
    }
}
//let redColor = UIColor(hexaString: "#ff0000")   // r 1.0 g 0.0 b 0.0 a 1.0


class FuncGlobal {
    
    func alert(titulo:String, info:String, btnTxt:String, viewController: UIViewController) {
        let popUp = UIAlertController(title: titulo, message: info, preferredStyle: UIAlertControllerStyle.Alert)
        popUp.addAction(UIAlertAction(title: btnTxt, style: UIAlertActionStyle.Default, handler: {alertAction in popUp.dismissViewControllerAnimated(true, completion: nil)}))
        viewController.presentViewController(popUp, animated: true, completion: nil)
    }
    
    func alertFocus(titulo:String, info:String, btnTxt:String, viewController: UIViewController, toFocus:UITextField) {
        let popUp = UIAlertController(title: titulo, message: info, preferredStyle: UIAlertControllerStyle.Alert)
        popUp.addAction(UIAlertAction(title: btnTxt, style: UIAlertActionStyle.Default, handler: {
            alertAction in self.subFocus(toFocus)
        }))
        viewController.presentViewController(popUp, animated: true, completion: nil)
    }
    
    func subFocus(toFocus:UITextField){
        toFocus.becomeFirstResponder()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func screenSize() -> CGSize {
        let screenSize = UIScreen.mainScreen().bounds.size
        if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
            return CGSizeMake(screenSize.height, screenSize.width)
        }
        return screenSize
    }
    /*
    
    // MARK: - NavigationBar methods
    func setupNavigationBar (viewController: UIViewController)
    {
        
        //current tab screen title
        tabBarController?.title = "Manage"
        
        //Hide back button or left bar button
        tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: " ", style: .Plain, target: nil, action: nil)
        
        //custom right bar button
        var image = UIImage(named: "dummy_settings_icon")
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action:  "settingButtonAction")
        viewController.navigationController?.navigationBar.topItem?.title = " "
    }*/
    
    
    
}