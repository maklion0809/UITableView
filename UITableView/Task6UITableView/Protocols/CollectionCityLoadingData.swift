//
//  asdfas.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 24.10.2021.
//

import Foundation

protocol CollectionCityLoadingData: TableViewLoadingData {
    func loadDataDescriptionInItem(indexPath: IndexPath, description: String)
    func loadDataExpendedObject(at section: Int, item: City)
    func removeExpendedObject(at section: Int, item: City)
}
