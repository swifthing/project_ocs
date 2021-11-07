//
//  URLsHelper.swift
//  OCSProject
//
//  Created by Anis on 04/11/2021.
//

import Foundation

struct URLsHelper {
    static func urlFromString (_ link: String) -> URL? {
        URL(string: "https://ocs.fr/" + link)
    }
}
