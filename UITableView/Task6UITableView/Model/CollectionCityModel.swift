//
//  CollectionCityModel.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 24.10.2021.
//

import Foundation

class CollectionCityModel: CollectionCityLoadingData {
    
    typealias T = City
    
    private var sections = [Section<City>]()
    
    func loadData() {
        let bestCitiesSection = Section<City>(name: "Best cities", objects: City.bestCities, expendedObject: Set<City>())
        let coolCitiesSection = Section<City>(name: "Cool cities", objects: City.coolCities, expendedObject: Set<City>())
        self.sections = [bestCitiesSection, coolCitiesSection]
    }

    var getData: [Section<City>] {
        sections
    }
    
    func loadDataSection(section: Section<City>) {
        sections.append(section)
    }
    
    func loadDataItemInSection(at section: Int, item: City) {
        sections[section].objects.append(item)
    }
    
    func loadDataDescriptionInItem(indexPath: IndexPath, description: String) {
        sections[indexPath.section].objects[indexPath.item].description = description
    }
    
    func loadDataExpendedObject(at section: Int, item: City) {
        sections[section].expendedObject.insert(item)
    }
    
    func removeExpendedObject(at section: Int, item: City) {
        sections[section].expendedObject.remove(item)
    }
    
    func removeItemInSection(at indexPath: IndexPath) {
        sections[indexPath.section].objects.remove(at: indexPath.item)
    }
}
