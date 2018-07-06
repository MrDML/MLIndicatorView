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

    override func viewDidLoad() {
        super.viewDidLoad()
        
         let indicatorView = MLIndicatorView.init(frame: CGRect.init(x: 100, y: 100, width: 30  , height: 30), tintColor: UIColor.red, indicatorStyle: .MLIndicatorStyleCyclingLine, indicatorOptional: nil)
         indicatorView.startIndicatorAnimation()
        self.view.addSubview(indicatorView)
    }

}

