//
//  UIStoryboard+AppAddition.swift
//  OCSProject
//
//  Created by Anis on 06/11/2021.
//

import UIKit

protocol Storyboardable {
    static var storyboardName: UIStoryboard.Names { get }
}

extension UIStoryboard {
    enum Names: String {
        case main = "Main"
    }
    
    convenience init(storyboardName: Names) {
        self.init(name: storyboardName.rawValue, bundle: nil)
    }
}
