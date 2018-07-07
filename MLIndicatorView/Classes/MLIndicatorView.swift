//
//  MLIndicatorView.swift
//  MLIndicatorView
//
//  Created by 戴明亮 on 2018/7/5.
//

import UIKit

@objc public enum MLIndicatorStyle:Int {
    case MLIndicatorStyleCyclingLine
    case MLIndicatorStyleCyclingRing
    case MLIndicatorStyleCyclingScale
    case MLIndicatorStyleTranslation
}

@objc open class MLIndicatorOptional: NSObject {
    // 线条宽度
    var lineWidth:CGFloat
    var reConut: Int
    var itemSize: CGSize
    var duration:CFTimeInterval
    
    
    init(lineWidth width:CGFloat,reConut count:Int, size:CGSize, duration:CFTimeInterval) {
        self.reConut = count
        self.lineWidth = width
        self.itemSize = size
        self.duration = duration
        super.init()
    }
   
}


@objc protocol MLIndicatorViewProtocol{
   @objc func setIndicatorAnimationWithSuperLayer(superLayer:CALayer, tintColor color:UIColor, indicatorSize size:CGSize,indicatorOptional optional:MLIndicatorOptional?)
    @objc func removeAnimation()
    
}

open class MLIndicatorView: UIView {

    let indicatorStyle:MLIndicatorStyle
    var indicatorProtocol:MLIndicatorViewProtocol! = nil
    let indicatorColor:UIColor
    let indicatorFrame:CGRect
    let indicatorOptional:MLIndicatorOptional?
    var object:AnyObject! = nil
    var isAnimating:Bool // 是否正在动画
    
    
    
    public init(frame: CGRect ,tintColor color: UIColor ,indicatorStyle style:MLIndicatorStyle,indicatorOptional optional:MLIndicatorOptional?) {
        indicatorFrame = frame
        indicatorColor = color
        indicatorStyle = style
        indicatorOptional = optional
        isAnimating = false
        super.init(frame: frame)
        
        addObserver()

    }
    
    public convenience init(tintColor color: UIColor ,indicatorStyle style:MLIndicatorStyle ,indicatorOptional optional:MLIndicatorOptional?) {
        self.init(frame: CGRect.zero, tintColor: color, indicatorStyle: style, indicatorOptional: optional)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addObserver(){
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterBackground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillBecomeActive), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc func appWillEnterBackground(){
        if isAnimating == true {
            self.indicatorProtocol.removeAnimation()
        }
    }
    
    @objc func appWillBecomeActive(){
        if isAnimating == true {
            self.startIndicatorAnimation()
        }
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self)
    }
    
    /// 获取指示器对象根据类型值
    ///
    /// - Parameter style: 类型
    /// - Returns: 指示器对象
    func getIndicatorOptionalWithStyle(style:MLIndicatorStyle) -> AnyObject{
        
        var object:AnyObject! = nil
        switch style {
        case .MLIndicatorStyleCyclingLine:
            object  = MLCyclingLine.init()
            break
        case .MLIndicatorStyleCyclingRing:
             object  = MLCyclingRing.init()
            break
        case .MLIndicatorStyleCyclingScale:
            object  = MLCyclingScale.init()
            break
        case .MLIndicatorStyleTranslation:
            object  = MLTranslation.init()
            break
        }
        return object
    }
    
    
    
   /// 开始动画
    public func startIndicatorAnimation(){
        // 这个值一定要清空
         self.layer.sublayers = nil;
        self.setIndicatorNormalState()
        self.object = self.getIndicatorOptionalWithStyle(style: indicatorStyle)
        self.indicatorProtocol = self.object as! MLIndicatorViewProtocol
        
        if self.object.responds(to: #selector(MLIndicatorViewProtocol.setIndicatorAnimationWithSuperLayer(superLayer:tintColor:indicatorSize:indicatorOptional:))){
            self.indicatorProtocol.setIndicatorAnimationWithSuperLayer(superLayer: self.layer, tintColor: indicatorColor, indicatorSize: indicatorFrame.size, indicatorOptional: indicatorOptional)
        }
        self.isAnimating = true
        
        
    }
    
    /// 停止动画
    public func stopIndicatorAnimation(){
        
        if self.isAnimating == true {
            self.indicatorProtocol = self.object as! MLIndicatorViewProtocol
            
            if self.object.responds(to: #selector(MLIndicatorViewProtocol.removeAnimation)){
                self.indicatorProtocol.removeAnimation()
                self.isAnimating = false
                self.indicatorProtocol = nil
                self.object = nil
            }
            self.setIndicatorToFadeOutState()
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    
    func setIndicatorNormalState(){
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.opacity = 1
        self.layer.speed = 1
    }
    
    func setIndicatorToFadeOutState(){
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.opacity = 0
        self.layer.sublayers = nil
    }
    
    
   
    
}



class MLCyclingLine: UIView,MLIndicatorViewProtocol {
    
    var realLayer:CAShapeLayer! = nil
    
   func setIndicatorAnimationWithSuperLayer(superLayer: CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional?) {
        let optionalTem:MLIndicatorOptional
        if let indicatorOptional = optional {
            optionalTem = indicatorOptional
        }else{
            optionalTem = MLIndicatorOptional.init(lineWidth: 1, reConut: 15, size: CGSize.init(width: 5, height: 5), duration:  Double(15) / Double(10))
        }
        
        let reLayer = CAReplicatorLayer.init()
        reLayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        reLayer.instanceCount = optionalTem.reConut
        reLayer.position = CGPoint.init(x: size.width * 0.5, y: size.height * 0.5)
        reLayer.backgroundColor = UIColor.clear.cgColor
        reLayer.instanceDelay =  optionalTem.duration / Double(optionalTem.reConut)
        
        let angle = CGFloat.pi * 2 / CGFloat(optionalTem.reConut)
        reLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        superLayer.addSublayer(reLayer)
        self.addRealLayerToReLayer(layer: reLayer, tintColor: color, indicatorSize: size, indicatorOptional: optionalTem)
        
    }
    
 
    func removeAnimation() {
        self.realLayer.removeAnimation(forKey: "animation")
    }
    
    
    func addRealLayerToReLayer(layer:CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional){
        
        self.realLayer = CAShapeLayer.init()
        self.realLayer.bounds = CGRect.init(x: 0, y: 0, width: optional.lineWidth, height: size.width/6)
        self.realLayer.position = CGPoint.init(x: size.width * 0.5, y: 5)
        self.realLayer.opacity = 0.9
        self.realLayer.cornerRadius = self.realLayer.bounds.size.width * 0.5
        self.realLayer.shouldRasterize = true
        self.realLayer.rasterizationScale = UIScreen.main.scale
        self.realLayer.backgroundColor = color.cgColor
        layer.addSublayer(self.realLayer)
        
        let animation = CABasicAnimation.init()
        animation.keyPath = "opacity"
        animation.fromValue = 0
        animation.toValue = 0.9
        
        animation.duration = optional.duration
        animation.repeatCount = MAXFLOAT
        
        self.realLayer.add(animation, forKey: "animation")
 
    }
    
}




class MLCyclingRing: UIView,MLIndicatorViewProtocol {
    
    var cyclingRinglayer:CAShapeLayer! = nil
    func setIndicatorAnimationWithSuperLayer(superLayer: CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional?) {
        
        let optionalTem:MLIndicatorOptional
        if let indicatorOptional = optional {
            optionalTem = indicatorOptional
        }else{
            optionalTem = MLIndicatorOptional.init(lineWidth: 1, reConut: 15, size: CGSize.init(width: 5, height: 5), duration: 1)
        }
        cyclingRinglayer = CAShapeLayer.init()
        cyclingRinglayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        cyclingRinglayer.opacity = 1;
        cyclingRinglayer.fillColor = UIColor.clear.cgColor
        cyclingRinglayer.strokeColor = color.cgColor
        cyclingRinglayer.position = CGPoint.init(x:  size.width * 0.5, y: size.height * 0.5)
        cyclingRinglayer.lineWidth = optionalTem.lineWidth
        
        let radius = size.width * 0.5
        let center = CGPoint.init(x: radius, y: radius)
        
       let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: 3 * (CGFloat.pi / 2), endAngle: 5 * (CGFloat.pi/4), clockwise: true)
        cyclingRinglayer.path = path.cgPath

        superLayer.addSublayer(cyclingRinglayer)
        
        
        let animation = CABasicAnimation.init()
        animation.keyPath = "transform.rotation"
        animation.repeatCount = MAXFLOAT
        animation.duration = optionalTem.duration
        animation.fromValue = 0
        animation.toValue = 2.0 * CGFloat.pi
        cyclingRinglayer.add(animation, forKey: "cyclingRinglayer")
        
    }
    
    func removeAnimation() {
        cyclingRinglayer.removeAnimation(forKey: "cyclingRinglayer")
    }
}



class MLCyclingScale: UIView,MLIndicatorViewProtocol {
    
    var realLayer:CAShapeLayer! = nil
    
    func setIndicatorAnimationWithSuperLayer(superLayer: CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional?) {
        let optionalTem:MLIndicatorOptional
        if let indicatorOptional = optional {
            optionalTem = indicatorOptional
        }else{
            optionalTem = MLIndicatorOptional.init(lineWidth: 1, reConut: 15, size: CGSize.init(width: 5, height: 5), duration: Double(15) / Double(10))
        }
        
        let reLayer = CAReplicatorLayer.init()
        reLayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        reLayer.instanceCount = optionalTem.reConut
        reLayer.backgroundColor = UIColor.clear.cgColor
        reLayer.position = CGPoint.init(x: size.width * 0.5, y: size.height * 0.5)
        
        reLayer.instanceDelay =  optionalTem.duration / CFTimeInterval(optionalTem.reConut)
        

         let angle = CGFloat.pi * 2 / CGFloat(optionalTem.reConut)
         reLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
         superLayer.addSublayer(reLayer)
        
        addRealLayerToReLayer(layer: reLayer, tintColor: color, indicatorSize: size, indicatorOptional: optionalTem)
        
    }
    
    
    func addRealLayerToReLayer(layer:CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional){
        
        self.realLayer = CAShapeLayer.init()
        self.realLayer.backgroundColor = color.cgColor
        self.realLayer.bounds = CGRect.init(x: 0, y: 0, width:  optional.itemSize.width, height: optional.itemSize.height)
        self.realLayer.position = CGPoint.init(x: size.width * 0.5, y: 5)
        self.realLayer.cornerRadius = self.realLayer.bounds.size.width * 0.5
        self.realLayer.shouldRasterize = true
        self.realLayer.rasterizationScale = UIScreen.main.scale
        self.realLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        

        layer.addSublayer(self.realLayer)
        
        let animation = CABasicAnimation.init()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 0.1
        animation.duration = optional.duration
        animation.repeatCount = MAXFLOAT
        self.realLayer.add(animation, forKey: "animation")
        
        
    }
    
    func removeAnimation() {
        self.realLayer.removeAnimation(forKey: "animation")
    }
    
    
}


class MLTranslation: UIView,MLIndicatorViewProtocol {
    
    var realLayer:CALayer! = nil
    
    func setIndicatorAnimationWithSuperLayer(superLayer: CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional?) {
        
        let optionalTem:MLIndicatorOptional
        if let indicatorOptional = optional {
            optionalTem = indicatorOptional
        }else{
            optionalTem = MLIndicatorOptional.init(lineWidth: 1, reConut: 5, size: CGSize.init(width: size.width / 5, height: size.height / 5), duration:0.8)
        }
        
        let reLayer = CAReplicatorLayer.init()
        reLayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        reLayer.position = CGPoint.init(x: 0, y: 0)
        reLayer.backgroundColor = UIColor.clear.cgColor
        reLayer.instanceCount = optionalTem.reConut
       
        superLayer.addSublayer(reLayer)
        
        reLayer.instanceTransform = CATransform3DMakeTranslation(size.width / CGFloat(optionalTem.reConut), 0, 0)
         reLayer.instanceDelay =  optionalTem.duration / CFTimeInterval(optionalTem.reConut)
      
        addRealLayerToReLayer(layer: reLayer, tintColor: color, indicatorSize: size, indicatorOptional: optionalTem)
    }
    
    
    
    func addRealLayerToReLayer(layer:CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional){
        
        self.realLayer = CALayer.init()
        
        self.realLayer.bounds = CGRect.init(x: 0, y: 0, width: optional.itemSize.width, height: optional.itemSize.height)

        self.realLayer.position = CGPoint.init(x: optional.itemSize.width * 0.5, y: size.height * 0.5)
        self.realLayer.backgroundColor = color.cgColor

        self.realLayer.cornerRadius = optional.itemSize.width * 0.5
        self.realLayer.shouldRasterize = true
        self.realLayer.rasterizationScale = UIScreen.main.scale
        self.realLayer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2)
        
        
        layer.addSublayer(self.realLayer)
        
        
       let animation = CABasicAnimation.init()
        animation.keyPath = "transform.scale"
        animation.fromValue = 0.2
        animation.toValue = 1
        animation.duration =  optional.duration
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        self.realLayer.add(animation, forKey: "animation")
        
        
        
    }
    
    func removeAnimation() {
        self.realLayer.removeAnimation(forKey: "animation")
    }
    
    
    
}












