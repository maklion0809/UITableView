//
//  sdfs.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 24.10.2021.
//

import Foundation

protocol TableViewLoadingData {
    associatedtype T: Hashable
    var sectionCount: Int { get }
    func getDataCount(in section: Int) -> Int 
    func getObject(for indexPath: IndexPath) -> T
    func getSectionName(at section: Int) -> String
    func loadData(at section: Section<T>)
    func loadDataItemInSection(at section: Int, item: T)
    func removeItemInSection(at indexPath: IndexPath)
}

