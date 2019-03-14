//
//  UIView+TappedExtension.swift
//  EWViewTappedExtension
//
//  EWeated by Ethan.Wang on 2018/10/22.
//  Copyright © 2018年 Ethan. All rights reserved.
//

//import Foundation
import UIKit

typealias EWTapGestureHanler = () -> Void

///添加点击事件协议
protocol UIViewTapable {
    ///单击事件
    var tapHandlers: [EWTapGestureHanler] { get }
    ///双击事件
    var doubleTapGestureHandlers: [EWTapGestureHanler] { get }
    ///长点事件
    var longTapGestureHandlers: [EWTapGestureHanler] { get }
    ///上滑事件
    var upSwipeGestureHandlers: [EWTapGestureHanler] { get }
    ///左滑事件
    var leftSwipeGestureHandlers: [EWTapGestureHanler] { get }
    ///右滑事件
    var rightSwipeGestureHandlers: [EWTapGestureHanler] { get }
    ///下滑事件
    var downSwipeGestureHandlers: [EWTapGestureHanler] { get }

    func whenTapped(handler:@escaping() -> Void)
    func whenDoubleTapped(handler:@escaping() -> Void)
    func whenLongPressed(handler:@escaping() -> Void)
    func whenUpSwiped(handler:@escaping() -> Void)
    func whenLeftSwiped(handler:@escaping() -> Void)
    func whenRightSwiped(handler:@escaping() -> Void)
    func whenDownSwiped(handler:@escaping() -> Void)

}
///runtime绑定方法时的key
class EWGestureAssociatedObjectKey {
    ///设置不同手势不同String标识
    static let EWTapGestureAssociatedObjectString  = "EWTapGestureAssociatedObjectString"
    ///获取String标识的内存地址作为runtime属性的Key
    static var EWTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(EWGestureAssociatedObjectKey.EWTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let EWDoubleTapGestureAssociatedObjectString  = "EWDoubleTapGestureAssociatedObjectString"
    static var EWDoubleTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(EWGestureAssociatedObjectKey.EWDoubleTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let EWLongTapGestureAssociatedObjectString  = "EWLongTapGestureAssociatedObjectString"
    static var EWLongTapGestureKey = {return Unmanaged<AnyObject>.passUnretained(EWGestureAssociatedObjectKey.EWLongTapGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let EWUpSwipeGestureAssociatedObjectString  = "EWUpSwipeGestureAssociatedObjectString"
    static var EWUpSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(EWGestureAssociatedObjectKey.EWUpSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let EWLeftSwipeGestureAssociatedObjectString  = "EWLeftSwipeGestureAssociatedObjectString"
    static var EWLeftSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(EWGestureAssociatedObjectKey.EWLeftSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let EWRightSwipeGestureAssociatedObjectString  = "EWRightSwipeGestureAssociatedObjectString"
    static var EWRightSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(EWGestureAssociatedObjectKey.EWRightSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

    static let EWDownSwipeGestureAssociatedObjectString  = "EWDownSwipeGestureAssociatedObjectString"
    static var EWDownSwipeGestureKey = {return Unmanaged<AnyObject>.passUnretained(EWGestureAssociatedObjectKey.EWDownSwipeGestureAssociatedObjectString as AnyObject).toOpaque()}()

}

extension UIView: UIViewTapable {
    var tapHandlers: [EWTapGestureHanler] {
        return EWOneTapGesture.tappedHandler
    }
    var doubleTapGestureHandlers: [EWTapGestureHanler] {
        return EWDoubleTapGesture.tappedHandler
    }
    var longTapGestureHandlers: [EWTapGestureHanler] {
        return EWLongTapGesture.tappedHandler
    }
    var upSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWUpSwipeGesture.tappedHandler
    }
    var leftSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWLeftSwipeGesture.tappedHandler
    }
    var rightSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWRightSwipeGesture.tappedHandler
    }
    var downSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWDownSwipeGesture.tappedHandler
    }
    ///runtime的方式为View设置手势属性
    var EWOneTapGesture: EWTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWTapGestureKey) as? EWTapGesture {
                return obj
            }
            let tapGesture = EWTapGesture(view: self)
            tapGesture.gesture.require(toFail: EWDoubleTapGesture.gesture)
            return tapGesture
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWDoubleTapGesture: EWTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWDoubleTapGestureKey) as? EWTapGesture {
                return obj
            }
            return EWTapGesture(view: self,taps: 2)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWDoubleTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWLongTapGesture:EWLongPressGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWLongTapGestureKey) as? EWLongPressGesture {
                return obj
            }
            return EWLongPressGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWLongTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWUpSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWUpSwipeGestureKey) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWUpSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWLeftSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWLeftSwipeGestureKey) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self, direction: .left)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWLeftSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWRightSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWRightSwipeGestureKey) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self, direction: .right)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWRightSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWDownSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWDownSwipeGestureKey) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self, direction: .down)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWDownSwipeGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func whenTapped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWOneTapGesture.registerHandler(handler)
    }

    func whenDoubleTapped(handler:@escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWDoubleTapGesture.registerHandler(handler)
    }

    func whenLongPressed(handler:@escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWLongTapGesture.registerHandler(handler)
    }

    func whenUpSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWUpSwipeGesture.registerHandler(handler)
    }

    func whenLeftSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWLeftSwipeGesture.registerHandler(handler)
    }

    func whenRightSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWRightSwipeGesture.registerHandler(handler)
    }

    func whenDownSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWDownSwipeGesture.registerHandler(handler)
    }

}
///单击双击手势
class EWTapGesture {
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UITapGestureRecognizer
    ///手势储存外界闭包
    fileprivate var tappedHandler = [EWTapGestureHanler]()

    init(view: UIView,taps: Int = 1) {
        myView = view
        ///手势
        gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = taps
        gesture.addTarget(self, action: #selector(EWTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        if taps == 1 {
            myView.EWOneTapGesture = self
        } else if taps == 2 {
            myView.EWDoubleTapGesture = self
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///将外界传入的block传入手势方法
    fileprivate func registerHandler(_ handler:@escaping EWTapGestureHanler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            handler()
        }
    }
}
///长按手势
class EWLongPressGesture {
    typealias EWLongPressGestureHandler = () -> Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UILongPressGestureRecognizer
    fileprivate var tappedHandler = [EWLongPressGestureHandler]()

    init(view:UIView,taps:Int = 1) {
        myView = view
        gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = TimeInterval(taps)
        gesture.addTarget(self, action: #selector(EWTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        myView.EWLongTapGesture = self
    }
    ///将外界传入的block传入手势方法
    fileprivate func registerHandler(_ handler:@escaping EWLongPressGestureHandler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            guard gesture.state == .began else { return }
            handler()
        }
    }
}
///滑动手势
class EWSwipeGesture {
    typealias EWSwipeGestureHandler = () -> Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UISwipeGestureRecognizer
    fileprivate var tappedHandler = [EWSwipeGestureHandler]()

    init(view:UIView,direction: UISwipeGestureRecognizer.Direction = .up) {
        myView = view
        gesture = UISwipeGestureRecognizer()
        gesture.direction = direction
        gesture.addTarget(self, action: #selector(EWTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        switch direction {
        case .up:
            myView.EWUpSwipeGesture = self
        case .left:
            myView.EWLeftSwipeGesture = self
        case .right:
            myView.EWRightSwipeGesture = self
        case .down:
            myView.EWDownSwipeGesture = self
        default:
            return
        }
    }
    fileprivate func registerHandler(_ handler:@escaping EWSwipeGestureHandler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            handler()
        }
    }
}
