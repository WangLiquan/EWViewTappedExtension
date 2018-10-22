//
//  ViewController.swift
//  EWViewTappedExtension
//
//  Created by Ethan.Wang on 2018/10/22.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    let tapView: UIView = {
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - 100)/2, y: 200, width: 100, height: 100))
        view.backgroundColor = UIColor.brown
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tapView)
        tapView.whenTapped {
            EWToast.showTopWithText(text: "点击事件", duration: 1)
        }
        tapView.whenUpSwiped {
            EWToast.showCenterWithText(text: "上滑事件", duration: 1)
        }
        tapView.whenLeftSwiped {
            EWToast.showCenterWithText(text: "左滑事件", duration: 1)
        }
        tapView.whenRightSwiped {
            EWToast.showCenterWithText(text: "右滑事件", duration: 1)
        }
        tapView.whenDownSwiped {
            EWToast.showCenterWithText(text: "下滑事件", duration: 1)
        }
        tapView.whenLongPressed {
            EWToast.showCenterWithText(text: "长按事件", duration: 1)
        }
        tapView.whenDoubleTapped {
            EWToast.showBottomWithText(text: "双击事件", duration: 1)
        }
    }


}

