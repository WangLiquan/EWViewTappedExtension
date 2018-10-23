# EWViewTappedExtension
<h3>使用拓展与runtime,为UIView添加手势事件</h3>

# 使用方法:
将UIView+TappedExtension.swift文件拖入项目,调用时:
```
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
```
<br>

![效果图预览](https://github.com/WangLiquan/EWViewTappedExtension/raw/master/images/demonstration.gif)
