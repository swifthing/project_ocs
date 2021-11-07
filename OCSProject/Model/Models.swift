//
//  Models.swift
//  OCSProject
//
//  Created by Anis on 02/11/2021.
//

import Foundation

struct Search: Codable {
    var title: String?
    var contents: [Contents]?
    
    struct Contents: Codable {
        var title: [Title]
        var subtitle: String
        var imageurl: String
        var fullscreenimageurl: String
        var id: String
        var detaillink: String
        var duration: String
    }
    
    struct Title: Codable {
        var color: String?
        var type: String
        var value: String
    }
}

struct Detail: Codable {
    var contents: Contents?
    
    struct Contents: Codable {
        var pitch: String
    }
}

