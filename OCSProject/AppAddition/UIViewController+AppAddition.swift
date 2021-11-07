//
//  UIViewController+AppAddition.swift
//  OCSProject
//
//  Created by Anis on 06/11/2021.
//

import UIKit

extension UIViewController {
    class var storyboardId: String {
        return String(describing: self)
    }
}
