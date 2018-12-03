import FluentPostgreSQL
import Foundation
import Vapor

final class User: Content, Parameter {
    var id: UUID?
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension User {
    var posts: Children<User, Post> {
        return self.children(\.userID)
    }
}

extension User: Migration {
    public static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.unique(on: \.username)
        }
    }
}

extension User: PostgreSQLUUIDModel {}
