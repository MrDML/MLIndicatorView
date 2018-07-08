# MLIndicatorView

[![CI Status](https://img.shields.io/travis/MrDML/MLIndicatorView.svg?style=flat)](https://travis-ci.org/MrDML/MLIndicatorView)
[![Version](https://img.shields.io/cocoapods/v/MLIndicatorView.svg?style=flat)](https://cocoapods.org/pods/MLIndicatorView)
[![License](https://img.shields.io/cocoapods/l/MLIndicatorView.svg?style=flat)](https://cocoapods.org/pods/MLIndicatorView)
[![Platform](https://img.shields.io/cocoapods/p/MLIndicatorView.svg?style=flat)](https://cocoapods.org/pods/MLIndicatorView)




## Preview

![Demo](https://github.com/MrDML/MLIndicatorView/blob/master/MLIndicatorViewGif.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Use

```Swift
/// 使用自定义的值
func exampleDemo_Custome(){

// 注意这里的复制图层的数量和动画时间有关联
let optional_OneStyle =  MLIndicatorOptional.init(lineWidth: 2, reConut: 15, size: CGSize.zero, duration: Double(15) / Double(10))
indicatorView_OneStyle = MLIndicatorView.init(frame: CGRect.init(x: 30, y: 100, width: 30, height: 30), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleCyclingLine, indicatorOptional: optional_OneStyle)
self.view.addSubview(indicatorView_OneStyle)


let optional_TwoStyle = MLIndicatorOptional.init(lineWidth: 2, reConut: 0, size: CGSize.zero, duration: 1)
indicatorView_TwoStyle = MLIndicatorView.init(frame: CGRect.init(x: (UIScreen.main.bounds.size.width - 60) * 0.5, y: 100, width: 30, height: 30), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleCyclingRing, indicatorOptional: optional_TwoStyle)
self.view.addSubview(indicatorView_TwoStyle)

// 注意这里的复制图层的数量和动画时间有关联 并且 size不能为空
let optional_ThreeStyle = MLIndicatorOptional.init(lineWidth: 1, reConut: 16, size: CGSize.init(width: 5, height: 5), duration: Double(16) / Double(10))
indicatorView_ThreeStyle = MLIndicatorView.init(frame: CGRect.init(x: 30, y: 200, width: 30 , height: 30), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleCyclingScale, indicatorOptional: optional_ThreeStyle)
self.view.addSubview(indicatorView_ThreeStyle)


// 注意这里的复制图层的数量和动画时间,size有关联 并且 size.width  size.height 需要确定frame
let optional_FourStyle = MLIndicatorOptional.init(lineWidth: 1, reConut: 5, size: CGSize.init(width: 30 / 5, height: 30 / 5), duration:0.8)

indicatorView_FourStyle = MLIndicatorView.init(frame: CGRect.init(x: (UIScreen.main.bounds.size.width - 60) * 0.5, y: 225, width: 30 , height: 30), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleTranslation, indicatorOptional: optional_FourStyle)
self.view.addSubview(indicatorView_FourStyle)
}



/// 使用默认的值
func exampleDemo_Default(){
indicatorView_OneStyle = MLIndicatorView.init(frame: CGRect.init(x: 30, y: 100, width: 60, height: 60), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleCyclingLine, indicatorOptional: nil)
self.view.addSubview(indicatorView_OneStyle)


indicatorView_TwoStyle = MLIndicatorView.init(frame: CGRect.init(x: (UIScreen.main.bounds.size.width - 60) * 0.5, y: 100, width: 60, height: 60), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleCyclingRing, indicatorOptional: nil)
self.view.addSubview(indicatorView_TwoStyle)

indicatorView_ThreeStyle = MLIndicatorView.init(frame: CGRect.init(x: 30, y: 200, width: 60 , height: 60), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleCyclingScale, indicatorOptional: nil)
self.view.addSubview(indicatorView_ThreeStyle)

indicatorView_FourStyle = MLIndicatorView.init(frame: CGRect.init(x: (UIScreen.main.bounds.size.width - 60) * 0.5, y: 225, width: 60 , height: 60), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleTranslation, indicatorOptional: nil)
self.view.addSubview(indicatorView_FourStyle)
}


override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
indicatorView_OneStyle.startIndicatorAnimation()
indicatorView_TwoStyle.startIndicatorAnimation()
indicatorView_ThreeStyle.startIndicatorAnimation()
indicatorView_FourStyle.startIndicatorAnimation()
}

```


## Requirements

## Installation

MLIndicatorView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MLIndicatorView'
```

## Author

MrDML, dml1630@163.com

## License

MLIndicatorView is available under the MIT license. See the LICENSE file for more info.
