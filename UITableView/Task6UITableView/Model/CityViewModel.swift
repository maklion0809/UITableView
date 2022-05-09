//
//  CollectionCityModel.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 24.10.2021.
//

import Foundation
import UIKit

final class CityViewModel: CollectionCityLoadingData {
        
    private var sections = [Section<City>]()
    
    func loadData() {
        let bestCitiesSection = Section<City>(name: "Best cities", objects: City.bestCities, expendedObject: Set<City>())
        let coolCitiesSection = Section<City>(name: "Cool cities", objects: City.coolCities, expendedObject: Set<City>())
        self.sections = [bestCitiesSection, coolCitiesSection]
    }
    
    func createSnaphot() -> NSDiffableDataSourceSnapshot<Section<City>, City> {
        var snapshot = NSDiffableDataSourceSnapshot<Section<City>, City>()
        sections.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(section.objects)
        }
        
        return snapshot
    }
    
    // MARK: - Load data
    
    var getAllSection: [Section<City>] {
        sections
    }
    
    var sectionCount: Int {
        sections.count
    }

    func getObject(for indexPath: IndexPath) -> City {
        sections[indexPath.section].objects[indexPath.item]
    }
    
    func isShowedExpendObject(at section: Int, item: City) -> Bool {
        sections[section].expendedObject.contains(item)
    }
    
    func getSectionName(at section: Int) -> String {
        sections[section].name
    }
    
    func getDataCount(in section: Int) -> Int {
        sections[section].objects.count
    }
    
    // MARK: - Insert
    
    func loadData(at section: Section<City>) {
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
    
    // MARK: - Remove
    
    func removeExpendedObject(at section: Int, item: City) {
        sections[section].expendedObject.remove(item)
    }
    
    func removeItemInSection(at indexPath: IndexPath) {
        sections[indexPath.section].objects.remove(at: indexPath.item)
    }
}
