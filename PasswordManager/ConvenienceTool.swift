//
//  ConvenienceTool.swift
//  关于Block的深入了解
//
//  Created by sks on 17/5/31.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit
typealias Task = (_ cancel : Bool) -> Void

func DPrint<T>(_ message: T, file: NSString = #file, method: String = #function, line: Int = #line)
{
    #if DEBUG
        print("\(method)[\(line)]: \(message)")
    #endif
}

class ConvenienceTool: NSObject {
    //屏幕 Size 高 宽
    static let HSCREEN_WIDTH = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? UIScreen.main.nativeBounds.size.width/UIScreen.main.nativeScale : UIScreen.main.bounds.size.width
    static let HSCREENH_HEIGHT = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? UIScreen.main.nativeBounds.size.height/UIScreen.main.nativeScale : UIScreen.main.bounds.size.height
    static let HSCREEN_SIZE = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.height / UIScreen.main.nativeScale) : UIScreen.main.bounds.size
    
    static let SCREEN_WIDTH = UIScreen.main.bounds.width
    static let SCREENH_HEIGHT = UIScreen.main.bounds.height
    static let SCREEN_SIZE = UIScreen.main.bounds.size
    // 随机颜色
    static var JYRandomColor : UIColor {
        get{
            return UIColor(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1.0)
        }
    }
    //设置 RGBA Color 颜色
    class func colorFromRGBA(red : CGFloat , green : CGFloat , blue : CGFloat , alpha : CGFloat) -> UIColor{
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    // 通过 十六进制 设置颜色
    class func colorFrom16(rgbValue: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    //软件版本
    static let jyVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    //系统版本
    static let jySystemVersion:String = UIDevice.current.systemVersion
    
    //设备类型型号
    static var jyPhoneModel : String {
        get{
            let modelName = UIDevice.current.model
            switch modelName {
            case "iPod touch":
                return "iPod"
            case "iPhone":
                return "iPhone"
            case "iPad":
                return "iPad"
            default:
                return "iPhone"
            }
        }
    }
    
    
    //随机数
    func random(in lower : Int , upper : Int) -> Int{
        let count = UInt32(upper - lower)
        return Int(arc4random_uniform(count)) + lower
    }
    //延迟执行
    func delay(_ time : TimeInterval , task : @escaping() -> ()) -> Task?{
        func dispatch_later(block : @escaping() -> ()){
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        
        var closure : (() -> Void)? = task
        var result : Task?
        
        let delayClosure : Task = {
            cancel in
            if let internalClosure = closure{
                if !cancel{
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        result = delayClosure
        dispatch_later {
            if let delauedClosure = result{
                delauedClosure(false)
            }
        }
        return result
    }
    
    func cancel(_ task : Task?){
        task?(true)
    }
}
//添加 GCD once
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

extension String {
    func sizeWithFont(font:UIFont,maxSize:CGSize) -> CGSize {
        
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
    }
}
extension String{
    // 判断输入的是否是纯数字
    func isNum() -> Bool {
        let regex = "^[0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: self) {
            return false
        }
        return true
    }
}
extension UIColor{
    public class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,blue: CGFloat(rgbValue & 0x0000FF) / 255.0,alpha: CGFloat(1.0))
    }
}

precedencegroup DotProductPrecedence{
    associativity: none
    higherThan : MultiplicationPrecedence
}
infix operator ~= : DotProductPrecedence

func ~=(lhs : String , rhs : String) -> Bool{
    do{
        return try RegexHelper(rhs).match(lhs)
    }catch{
        return false
    }
}
struct RegexHelper{
    let regex : NSRegularExpression
    init(_ pattern : String)throws {
        try regex = NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
    }
    
    func match(_ input : String) -> Bool{
        let matches = regex.matches(in: input, options: [], range: NSRange(location : 0 , length : input.utf16.count))
        return matches.count > 0
    }
}








