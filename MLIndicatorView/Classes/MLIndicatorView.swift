//
//  MLIndicatorView.swift
//  MLIndicatorView
//
//  Created by 戴明亮 on 2018/7/5.
//

import UIKit

public enum MLIndicatorStyle {
    case MLIndicatorStyleCyclingLine
    case MLIndicatorStyleCyclingRing
    case MLIndicatorStyleBounceSport
}


public struct MLIndicatorOptional {
    // 线条宽度
    var lineWidth:CGFloat
    var reConut: Int
    // 修改默认值
    mutating func fixDefaultValue(lineWidth width:CGFloat ,reConut count:Int){
        self.reConut = count
        self.lineWidth = width
    }
    
    
}


protocol MLIndicatorViewProtocol:NSObjectProtocol{
    func setIndicatorAnimationWithSuperLayer(superLayer:CALayer, tintColor color:UIColor, indicatorSize size:CGSize,indicatorOptional optional:MLIndicatorOptional?)
    func removeAnimation()
    
}

open class MLIndicatorView: UIView {

    
    let str :[String]? = nil
    let indicatorStyle:MLIndicatorStyle
    var indicatorProtocol:MLIndicatorViewProtocol! = nil
    let indicatorColor:UIColor
    let indicatorFrame:CGRect
    let indicatorOptional:MLIndicatorOptional?
    
    
    
    public init(frame: CGRect ,tintColor color: UIColor ,indicatorStyle style:MLIndicatorStyle,indicatorOptional optional:MLIndicatorOptional?) {
        indicatorFrame = frame
        indicatorColor = color
        indicatorStyle = style
        indicatorOptional = optional
        super.init(frame: frame)
        
        let a: Set<String> = Set.init()
        
        
    }
    
    public convenience init(tintColor color: UIColor ,indicatorStyle style:MLIndicatorStyle ,indicatorOptional optional:MLIndicatorOptional?) {
        self.init(frame: CGRect.zero, tintColor: color, indicatorStyle: style, indicatorOptional: optional)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            
            break
        case .MLIndicatorStyleBounceSport:
            
            break
        }
        return object
        
//        if let indicatorProtocolTemp = self.indicatorProtocol {
//            return indicatorProtocolTemp
//        }else{ // 默认值
//            return MLCyclingLine.init() as MLIndicatorViewProtocol
//        }
    }
    
    
    
   /// 开始动画
    public func startIndicatorAnimation(){
        
     
        
       let object = self.getIndicatorOptionalWithStyle(style: indicatorStyle)
//        object.
        
        
//        if object.responds(to: #selector(MLIndicatorViewProtocol.setIndicatorAnimationWithSuperLayer(superLayer:tintColor:indicatorSize:indicatorOptional:))) {
//            print("实现")
//        }else{
//            print("未实现")
//        }
//
        
//        if (self.indicatorProtocol.responds(to: #selector(MLIndicatorViewProtocol.setIndicatorAnimationWithSuperLayer(superLayer:tintColor:indicatorSize:indicatorOptional:)))) {
//
//        }
    
        
//        self.indicatorProtocol?.setIndicatorAnimationWithSuperLayer(superLayer: self.layer, tintColor: indicatorColor, indicatorSize: indicatorFrame.size, indicatorOptional: indicatorOptional)
        
    }
    
   /// 停止动画
   public func stopIndicatorAnimation(){
        self.indicatorProtocol?.removeAnimation()
    }
    
}



class MLCyclingLine: UIView,MLIndicatorViewProtocol {
    
    var realLayer:CAShapeLayer! = nil
    
   func setIndicatorAnimationWithSuperLayer(superLayer: CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional?) {
        let optionalTem:MLIndicatorOptional
        if let indicatorOptional = optional {
            optionalTem = indicatorOptional
        }else{
            optionalTem = MLIndicatorOptional.init(lineWidth: 1, reConut: 15)
        }
        
        let relayer = CAReplicatorLayer.init()
        relayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        relayer.instanceCount = optionalTem.reConut
        relayer.position = CGPoint.init(x: 0, y: 0)
        relayer.backgroundColor = UIColor.clear.cgColor
        /**
         指定复制副本之间的延迟（以秒为单位）。动画。
         默认值为0.0，表示将同步添加到复制副本的任何动画。
         以下代码显示了用于创建动画活动监视器的复制器层。 复制器层创建30个小圆圈，形成一个更大的圆圈。 源图层圆圈具有1秒的动画淡出效果，每个副本将动画的时间偏移1/30秒。
         let replicatorLayer = CAReplicatorLayer()
         
         let circle = CALayer()
         circle.frame = CGRect(origin: CGPoint.zero,
         size: CGSize(width: 10, height: 10))
         circle.backgroundColor = NSColor.blue.cgColor
         circle.cornerRadius = 5
         circle.position = CGPoint(x: 0, y: 50)
         replicatorLayer.addSublayer(circle)
         
         let fadeOut = CABasicAnimation(keyPath: "opacity")
         fadeOut.fromValue = 1
         fadeOut.toValue = 0
         fadeOut.duration = 1
         fadeOut.repeatCount = Float.greatestFiniteMagnitude
         circle.add(fadeOut, forKey: nil)
         
         
         let instanceCount = 30
         replicatorLayer.instanceCount = instanceCount
         replicatorLayer.instanceDelay = fadeOut.duration / CFTimeInterval(instanceCount)
         
         let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
         replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
         so animation.duration = Double(optional.reConut) / Double(10) 需要对应
         */
        relayer.instanceDelay =  (Double(optionalTem.reConut) / Double(10)) / Double(optionalTem.reConut)
        
        /// 每个复制层的角度值
        let angle = CGFloat.pi * 2 / CGFloat(optionalTem.reConut)
        relayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        superLayer.addSublayer(relayer)
        self.addRealLayerToReLayer(layer: relayer, tintColor: color, indicatorSize: size, indicatorOptional: optionalTem)
        
    }
    
 
    func removeAnimation() {
        realLayer.removeAnimation(forKey: "animation")
    }
    
    
    func addRealLayerToReLayer(layer:CALayer, tintColor color: UIColor, indicatorSize size: CGSize, indicatorOptional optional: MLIndicatorOptional){
        
        
        realLayer = CAShapeLayer.init()
        realLayer.bounds = CGRect.init(x: 0, y: 0, width: optional.lineWidth, height: size.width/6)
        realLayer.position = CGPoint.init(x: size.width/2, y: 5)
        realLayer.opacity = 0.9
        realLayer.cornerRadius = 1
        realLayer.shouldRasterize = true
        realLayer.rasterizationScale = UIScreen.main.scale
        realLayer.backgroundColor = color.cgColor
        layer.addSublayer(realLayer)
        
        let animation = CABasicAnimation.init()
        animation.keyPath = "opacity"
        animation.fromValue = 0
        animation.toValue = 0.9
        
        animation.duration = Double(optional.reConut) / Double(10)
        animation.repeatCount = MAXFLOAT
        
        realLayer.add(animation, forKey: "animation")
        
        
        
    }
    
    
    

    
    
  
    
    
}





