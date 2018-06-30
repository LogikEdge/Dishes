//
//  DishController.swift
//  App
//
//  Created by Michel Launier on 2018-06-21.
//

import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `Dish`s.
final class DishesController {

    func getAll(req : Request) -> Future<[Dish]> {
        return Dish.query(on: req).all()
    }
}
//
