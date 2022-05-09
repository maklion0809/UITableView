//
//  City.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 04.10.2021.
//

import UIKit

struct City {
    let name: String
    let image: String
    var description: String
}

extension City {
    static let bestCities = [
        City(name: "city one", image: "cityOne", description: "Some description"),
        City(name: "city two", image: "cityTwo", description: "Some description"),
        City(name: "city three", image: "cityThree", description: "Some description"),
        City(name: "city four", image: "cityFour", description: "Some description"),
        City(name: "city five", image: "cityFive", description: "Some description")
    ]
    static let coolCities = [
        City(name: "city six", image: "citySix", description: "Some description"),
        City(name: "city seven", image: "citySeven", description: "Some description"),
        City(name: "city eight", image: "cityEight", description: "Some description")
    ]
}

//MARK: - Hashable

extension City: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(image)
        hasher.combine(description)
    }
}
