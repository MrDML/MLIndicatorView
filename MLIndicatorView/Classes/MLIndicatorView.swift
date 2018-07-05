//
//  MLIndicatorView.swift
//  MLIndicatorView
//
//  Created by 戴明亮 on 2018/7/5.
//

import UIKit

enum MLIndicatorStyle {
    case MLIndicatorStyleCyclingLine
    case MLIndicatorStyleCyclingCycle
    case MLIndicatorStyleBounceSport
}

open class MLIndicatorView: UIView {

    
    public init(frame: CGRect ,tintColor color: UIColor) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setSubViews(){
        
    }
    

}
