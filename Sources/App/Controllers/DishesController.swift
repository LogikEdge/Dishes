//
//  DishController.swift
//  App
//
//  Created by Michel Launier on 2018-06-21.
//

import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `Dish`s.
final class DishesController : RouteCollection {

    func boot(router: Router) throws {
        
        let dishesRoute = router.grouped("api/dishes")
        
        dishesRoute.get("/", use: getAll)
        dishesRoute.get(Dish.parameter, use: getById)
        dishesRoute.get("course", String.parameter, use: getByCourse)
        dishesRoute.delete(Dish.parameter, use: deleteById)
        dishesRoute.post(Dish.self, at: "/", use: add)
    }
    
    func getAll(req : Request) -> Future<[Dish]> {
        return Dish.query(on: req).all()
    }
    
    func getById(req : Request) throws -> Future<Dish> {
        return try req.parameters.next(Dish.self)
    }
    
    func getByCourse(req : Request) throws -> Future<[Dish]> {
        let course = try req.parameters.next(String.self)
        return Dish.query(on: req).filter(\.course == course).all()
    }
    
    func deleteById(req : Request) throws -> Future<Dish> {
        return try req.parameters.next(Dish.self).delete(on: req)
    }
    
    func add(req : Request, dish : Dish) throws -> Future<Dish> {
        return dish.save(on: req)
    }
}

