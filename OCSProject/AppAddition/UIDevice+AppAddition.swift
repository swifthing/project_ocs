//
//  UIDevice+AppAddition.swift
//  OCSProject
//
//  Created by Anis on 06/11/2021.
//

import Foundation
import UIKit

extension UIDevice {
    static var isIPhone: Bool {
        if (UIApplication.shared.delegate as? AppDelegate)?.window?.traitCollection.userInterfaceIdiom == .phone {
            return true
        }
        
        let horizontalSizeClass = (UIApplication.shared.delegate as? AppDelegate)?.window?.traitCollection.horizontalSizeClass
        let verticalSizeClass = (UIApplication.shared.delegate as? AppDelegate)?.window?.traitCollection.verticalSizeClass
        return horizontalSizeClass != verticalSizeClass
    }
    
    static var isIPad: Bool {
        let horizontalSizeClass = (UIApplication.shared.delegate as? AppDelegate)?.window?.traitCollection.horizontalSizeClass
        let verticalSizeClass = (UIApplication.shared.delegate as? AppDelegate)?.window?.traitCollection.verticalSizeClass
        return horizontalSizeClass == verticalSizeClass
    }
}
