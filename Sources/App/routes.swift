import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Register dish controller
    let dishesController = DishesController()
    try router.register(collection: dishesController)

}
