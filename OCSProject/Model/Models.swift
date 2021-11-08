//
//  Models.swift
//  OCSProject
//
//  Created by Anis on 02/11/2021.
//

import Foundation

struct Search: Codable, Equatable {
    
    var title: String?
    var contents: [Contents]?
    
    struct Contents: Codable, Equatable {
        var title: [Title]
        var subtitle: String
        var imageurl: String
        var fullscreenimageurl: String
        var id: String
        var detaillink: String
        var duration: String
        
        static func == (lhs: Contents, rhs: Contents) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    struct Title: Codable {
        var color: String?
        var type: String
        var value: String
    }
    
    static func == (lhs: Search, rhs: Search) -> Bool {
        lhs.contents == rhs.contents
    }
}

struct Detail: Codable {
    var contents: Contents?
    
    struct Contents: Codable {
        var pitch: String
    }
    
    static func == (lhs: Detail, rhs: Detail) -> Bool {
        lhs.contents?.pitch ?? "" == rhs.contents?.pitch ?? ""
    }
}

