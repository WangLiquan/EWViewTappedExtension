//
//  UIView+TappedExtension.swift
//  EWViewTappedExtension
//
//  Created by Ethan.Wang on 2018/10/22.
//  Copyright © 2018年 Ethan. All rights reserved.
//

//import Foundation
import UIKit
///添加点击事件协议
protocol UIViewTapable {
    ///单击事件
    var tapHandlers: [CRTapGestureHanler] { get }
    ///双击事件
    var doubleTapGestureHandlers: [CRTapGestureHanler]{ get }
    ///长点事件
    var longTapGestureHandlers: [CRTapGestureHanler]{ get }
    ///上滑事件
    var upSwipeGestureHandlers: [CRTapGestureHanler]{ get }
    ///左滑事件
    var leftSwipeGestureHandlers: [CRTapGestureHanler]{ get }
    ///右滑事件
    var rightSwipeGestureHandlers: [CRTapGestureHanler]{ get }
    ///下滑事件
    var downSwipeGestureHandlers: [CRTapGestureHanler]{ get }

    func whenTapped(handler:@escaping()->Void)
    func whenDoubleTapped(handler:@escaping()->Void)
    func whenLongPressed(handler:@escaping()->Void)
    func whenUpSwiped(handler:@escaping()->Void)
    func whenLeftSwiped(handler:@escaping()->Void)
    func whenRightSwiped(handler:@escaping()->Void)
    func whenDownSwiped(handler:@escaping()->Void)

}
///runtime绑定方法时的key
class CRGestureAssociatedObjectKey {
    static let CRTapGestureAssociatedObjectString  = "CRTapGestureAssociatedObjectString"
    static var CRTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(CRGestureAssociatedObjectKey.CRTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let CRDoubleTapGestureAssociatedObjectString  = "CRDoubleTapGestureAssociatedObjectString"
    static var CRDoubleTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(CRGestureAssociatedObjectKey.CRDoubleTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let CRLongTapGestureAssociatedObjectString  = "CRLongTapGestureAssociatedObjectString"
    static var CRLongTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(CRGestureAssociatedObjectKey.CRLongTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let CRUpSwipeGestureAssociatedObjectString  = "CRUpSwipeGestureAssociatedObjectString"
    static var CRUpSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(CRGestureAssociatedObjectKey.CRUpSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let CRLeftSwipeGestureAssociatedObjectString  = "CRLeftSwipeGestureAssociatedObjectString"
    static var CRLeftSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(CRGestureAssociatedObjectKey.CRLeftSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let CRRightSwipeGestureAssociatedObjectString  = "CRRightSwipeGestureAssociatedObjectString"
    static var CRRightSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(CRGestureAssociatedObjectKey.CRRightSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let CRDownSwipeGestureAssociatedObjectString  = "CRRightSwipeGestureAssociatedObjectString"
    static var CRDownSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(CRGestureAssociatedObjectKey.CRDownSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

}

typealias CRTapGestureHanler = ()->Void

extension UIView: UIViewTapable {
    var tapHandlers: [CRTapGestureHanler]{
        return crTapGesture.tappedHandler
    }
    var doubleTapGestureHandlers: [CRTapGestureHanler]{
        return crDoubleTapGesture.tappedHandler
    }
    var longTapGestureHandlers: [CRTapGestureHanler]{
        return crLongTapGesture.tappedHandler
    }
    var upSwipeGestureHandlers: [CRTapGestureHanler] {
        return crUpSwipeGesture.tappedHandler
    }
    var leftSwipeGestureHandlers: [CRTapGestureHanler] {
        return crLeftSwipeGesture.tappedHandler
    }
    var rightSwipeGestureHandlers: [CRTapGestureHanler] {
        return crRightSwipeGesture.tappedHandler
    }
    var downSwipeGestureHandlers: [CRTapGestureHanler] {
        return crDownSwipeGesture.tappedHandler
    }
    ///runtime的方式为View设置手势属性
    var crTapGesture: CRTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, CRGestureAssociatedObjectKey.CRTapGestureKey) as? CRTapGesture {
                return obj
            }
            let tapGesture = CRTapGesture(view: self)
            tapGesture.gesture.require(toFail: crDoubleTapGesture.gesture)
            return tapGesture
        }
        set {
            objc_setAssociatedObject(self, CRGestureAssociatedObjectKey.CRTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var crDoubleTapGesture: CRTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, CRGestureAssociatedObjectKey.CRDoubleTapGestureKey) as? CRTapGesture {
                return obj
            }
            return CRTapGesture(view: self,taps: 2)
        }
        set {
            objc_setAssociatedObject(self, CRGestureAssociatedObjectKey.CRDoubleTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var crLongTapGesture:CRLongPressGesture {
        get {
            if let obj = objc_getAssociatedObject(self, CRGestureAssociatedObjectKey.CRLongTapGestureKey) as? CRLongPressGesture {
                return obj
            }
            return CRLongPressGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, CRGestureAssociatedObjectKey.CRLongTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var crUpSwipeGesture: CRSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, CRGestureAssociatedObjectKey.CRUpSwipeGestureKey) as? CRSwipeGesture {
                return obj
            }
            return CRSwipeGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, CRGestureAssociatedObjectKey.CRUpSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var crLeftSwipeGesture: CRSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, CRGestureAssociatedObjectKey.CRLeftSwipeGestureKey) as? CRSwipeGesture {
                return obj
            }
            return CRSwipeGesture(view: self, direction: .left)
        }
        set {
            objc_setAssociatedObject(self, CRGestureAssociatedObjectKey.CRLeftSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var crRightSwipeGesture: CRSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, CRGestureAssociatedObjectKey.CRRightSwipeGestureKey) as? CRSwipeGesture {
                return obj
            }
            return CRSwipeGesture(view: self, direction: .right)
        }
        set {
            objc_setAssociatedObject(self, CRGestureAssociatedObjectKey.CRRightSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var crDownSwipeGesture: CRSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, CRGestureAssociatedObjectKey.CRDownSwipeGestureKey) as? CRSwipeGesture {
                return obj
            }
            return CRSwipeGesture(view: self, direction: .down)
        }
        set {
            objc_setAssociatedObject(self, CRGestureAssociatedObjectKey.CRDownSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func whenTapped(handler: @escaping () -> Void){
        self.isUserInteractionEnabled = true
        self.crTapGesture.registerHandler(handler)
    }

    func whenDoubleTapped(handler:@escaping ()->Void){
        self.isUserInteractionEnabled = true
        self.crDoubleTapGesture.registerHandler(handler)
    }

    func whenLongPressed(handler:@escaping ()->Void){
        self.isUserInteractionEnabled = true
        self.crLongTapGesture.registerHandler(handler)
    }

    func whenUpSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.crUpSwipeGesture.registerHandler(handler)
    }

    func whenLeftSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.crLeftSwipeGesture.registerHandler(handler)
    }

    func whenRightSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.crRightSwipeGesture.registerHandler(handler)
    }

    func whenDownSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.crDownSwipeGesture.registerHandler(handler)
    }

}
///单击双击手势
class CRTapGesture: NSObject, UIGestureRecognizerDelegate{
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UITapGestureRecognizer
    var tappedHandler = [CRTapGestureHanler]()

    init(view:UIView,taps:Int = 1) {
        myView = view
        ///手势
        gesture = UITapGestureRecognizer()
        super.init()
        gesture.delegate = self
        gesture.numberOfTapsRequired = taps
        gesture.addTarget(self, action: #selector(CRTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        if taps == 1 {
            myView.crTapGesture = self
        }else if taps == 2{
            myView.crDoubleTapGesture = self
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func registerHandler(_ handler:@escaping CRTapGestureHanler){
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler{
            handler()
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == myView{
            return true
        }
        return false
    }
}
///长按手势
class CRLongPressGesture {

    typealias CRLongPressGestureHandler = ()->Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UILongPressGestureRecognizer
    var tappedHandler = [CRLongPressGestureHandler]()

    init(view:UIView,taps:Int = 1) {
        myView = view
        gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = TimeInterval(taps)
        gesture.addTarget(self, action: #selector(CRTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        myView.crLongTapGesture = self
    }
    func registerHandler(_ handler:@escaping CRLongPressGestureHandler){
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler{
            guard gesture.state == .began else { return }
            handler()
        }
    }
}
///滑动手势
class CRSwipeGesture {
    typealias CRSwipeGestureHandler = ()->Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UISwipeGestureRecognizer
    var tappedHandler = [CRSwipeGestureHandler]()

    init(view:UIView,direction: UISwipeGestureRecognizer.Direction = .up) {
        myView = view
        gesture = UISwipeGestureRecognizer()
        gesture.direction = direction
        gesture.addTarget(self, action: #selector(CRTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        switch direction {
        case .up:
            myView.crUpSwipeGesture = self
        case .left:
            myView.crLeftSwipeGesture = self
        case .right:
            myView.crRightSwipeGesture = self
        case .down:
            myView.crDownSwipeGesture = self
        default:
            return
        }
    }
    func registerHandler(_ handler:@escaping CRSwipeGestureHandler){
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler{
            handler()
        }
    }
}
