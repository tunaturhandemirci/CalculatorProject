//
//  CGFloat+Ext.swift
//  CalculatorMVVM
//
//  Created by Tuna Demirci on 26.08.2024.
//

import UIKit

// MARK: - UIView Extension

extension UIView {
    
    var screenWidth : CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight : CGFloat {
        return UIScreen.main.bounds.width
    }
}

// MARK: - UIViewController Extension

extension UIViewController {
    
    var screenWidth : CGFloat {
        return view.frame.size.width
    }
    
    var screenHeight : CGFloat {
        return view.frame.size.height
    }
}
