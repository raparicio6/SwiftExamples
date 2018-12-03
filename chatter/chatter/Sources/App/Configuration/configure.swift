import FluentPostgreSQL
import Vapor

public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    try services.register(FluentPostgreSQLProvider())
    
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)

    var databases = DatabasesConfig()
    let config = PostgreSQLDatabaseConfig(hostname: "localhost", username: "tdl", database: "chatter", password: "tdl")
    databases.add(database: PostgreSQLDatabase(config: config), as: .psql)
    services.register(databases)

    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    services.register(migrations)
    
    var commands = CommandConfig.default()
    commands.useFluentCommands()
    services.register(commands)
}
