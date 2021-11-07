//
//  NavigationRouteur.swift
//  OCSProject
//
//  Created by Anis on 05/11/2021.
//

import Foundation
import UIKit

struct NavigationRouter {
    static func pushViewController<T: UIViewController>(ofType: T.Type, on presentingViewController : UIViewController, animated: Bool = true, controllerIdentifier: String = T.storyboardId, configurationHandler configure: ((T)->Void)? = nil) where T: Storyboardable {
        if let destinationController = UIStoryboard(name: T.storyboardName.rawValue, bundle: nil).instantiateViewController(withIdentifier: controllerIdentifier) as? T {
            configure?(destinationController)
            presentingViewController.navigationController?.pushViewController(destinationController, animated: animated)
        }
    }
}
