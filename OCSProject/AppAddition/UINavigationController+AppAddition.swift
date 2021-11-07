//
//  UINavigationController+AppAddition.swift
//  OCSProject
//
//  Created by Anis on 05/11/2021.
//

import UIKit

extension UINavigationController {
    func rootViewController<T: UIViewController>() -> T? {
        return viewControllers.first as? T
    }
}
