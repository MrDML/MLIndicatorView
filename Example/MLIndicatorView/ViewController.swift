//
//  ViewController.swift
//  MLIndicatorView
//
//  Created by MrDML on 07/05/2018.
//  Copyright (c) 2018 MrDML. All rights reserved.
//

import UIKit
import MLIndicatorView
class ViewController: UIViewController {
    var indicatorView_OneStyle:MLIndicatorView! = nil
    var indicatorView_TwoStyle:MLIndicatorView! = nil
    var indicatorView_ThreeStyle:MLIndicatorView! = nil
    var indicatorView_FourStyle:MLIndicatorView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

