//
//  Section.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 04.10.2021.
//

import Foundation

struct Section<T: Hashable>: Hashable {
    let name: String
    var objects: [T]
    var expendedObject: Set<T>
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(objects)
        hasher.combine(expendedObject)
    }
}

