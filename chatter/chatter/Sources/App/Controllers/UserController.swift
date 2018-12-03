import Vapor
import Fluent
import FluentSQL

final class UserController: RouteCollection {
    func boot(router: Router) throws {
        let users = router.grouped("users")
        
        users.post(User.self, use: create)
        users.post(User.parameter, "follow", use: follow)
        
        users.get(use: index)
        users.get(User.parameter, use: show)
        users.get(User.parameter, "followers", use: followers)
        users.get(User.parameter, "following", use: following)
        users.get("search", use: search)
        
        users.patch(UserContent.self, at: User.parameter, use: update)
        
        users.delete(User.parameter, use: delete)
        users.delete(User.parameter, "un-follow", use: unfollow)
    }
    
    func create(_ request: Request, _ user: User)throws -> Future<User> {
        return user.save(on: request)
    }
    
    func follow(_ request: Request)throws -> Future<[String: User]> {
        let current = try request.parameters.next(User.self)
        let followID = request.content.get(User.ID.self, at: "follow")
        let follow = followID.and(result: request).flatMap(User.find).unwrap(or: Abort(.badRequest, reason: "Unable to find user with ID"))
        
        return flatMap(to: (current: User, following: User).self, current, follow) { current, follow in
            return current.follow(user: follow, on: request)
        }.map { users in
            return ["current": users.current, "following": users.following]
        }
    }
    
    func index(_ request: Request)throws -> Future<[User]> {
        return User.query(on: request).all()
    }
    
    func show(_ request: Request)throws -> Future<User> {
        return try request.parameters.next(User.self)
    }
    
    func followers(_ request: Request)throws -> Future<[User]> {
        return try request.parameters.next(User.self).flatMap { user in
            return try user.followers.query(on: request).all()
        }
    }
    
    func following(_ request: Request)throws -> Future<[User]> {
        return try request.parameters.next(User.self).flatMap { user in
            return try user.following.query(on: request).all()
        }
    }
    
    func search(_ request: Request)throws -> Future<[User]> {
        let name = try request.query.get(String.self, at: "name")
        return User.query(on: request).group(.or) { query in
            query.filter(\.username =~ name)
        }.all()
    }
    
    func update(_ request: Request, _ body: UserContent)throws -> Future<User> {
        let user = try request.parameters.next(User.self)
        return user.map(to: User.self) { user in
            user.username = body.username ?? user.username
            user.password = body.password ?? user.password
            return user
        }.update(on: request)
    }
    
    func delete(_ request: Request)throws -> Future<HTTPStatus> {
        return try request.parameters.next(User.self).delete(on: request).transform(to: .noContent)
    }
    
    func unfollow(_ request: Request)throws -> Future<HTTPStatus> {
        let current = try request.parameters.next(User.self)
        let followingID = request.content.get(User.ID.self, at: "unfollow")
        let following = followingID.and(result: request).flatMap(User.find).unwrap(or: Abort(.badRequest, reason: "Unable to find user with ID"))
        
        return flatMap(to: HTTPStatus.self, current, following) { current, following in
            return current.unfollow(user: following, on: request).transform(to: .noContent)
        }
    }
}

struct UserContent: Content {
    var username: String?
    var password: String?
}
