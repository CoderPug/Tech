//
//  Host.swift
//  Hello
//
//  Created by Jose Torres on 1/11/16.
//
//

import Vapor
import Fluent

final class Host: Model {
    
    var id: Node?
    var name: String
    var url: String
    var imageURL: String
    
    init(name: String, url: String, imageURL: String) {
        self.name = name
        self.url = url
        self.imageURL = imageURL
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        url = try node.extract("url")
        imageURL = try node.extract("imageurl")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "url": url,
            "imageurl": imageURL
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("hosts") { episodes in
            episodes.id()
            episodes.string("name")
            episodes.string("url")
            episodes.string("imageurl")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("hosts")
    }
}
