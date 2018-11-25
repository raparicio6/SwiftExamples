import FluentPostgreSQL

final class UserConnection: PostgreSQLPivot {
    typealias Left = User
    typealias Right = User
    
    static var leftIDKey: WritableKeyPath<UserConnection, UUID> = \.leftID
    static var rightIDKey: WritableKeyPath<UserConnection, UUID> = \.rightID
    
    var id: Int?
    var leftID: UUID
    var rightID: UUID
    
    init(left: User, right: User)throws {
        self.leftID = try left.requireID()
        self.rightID = try right.requireID()
    }
}

extension UserConnection: Migration {}


extension User {
    var following: Siblings<User, User, UserConnection> {
        return self.siblings(\UserConnection.leftID, \UserConnection.rightID)
    }
    
    var followers: Siblings<User, User, UserConnection> {
        return self.siblings(\UserConnection.rightID, \UserConnection.leftID)
    }
    
    func follow(user: User, on connection: DatabaseConnectable) -> Future<(current: User, following: User)> {
        return Future.flatMap(on: connection) {
            let pivot = try UserConnection(left: self, right: user)
            return pivot.save(on: connection).transform(to: (self, user))
        }
    }
    
    func unfollow(user: User, on connection: DatabaseConnectable) -> Future<(current: User, unfollowed: User)> {
        return self.following.detach(user, on: connection).transform(to: (self, user))
    }
}
