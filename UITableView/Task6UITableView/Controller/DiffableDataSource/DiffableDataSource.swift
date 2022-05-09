//
//  DiffableDataSource.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 05.10.2021.
//

import UIKit

final class DiffableDataSource: UITableViewDiffableDataSource<Section<City>, City> {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        snapshot().sectionIdentifiers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        snapshot().sectionIdentifiers[section].objects.count
    }
}
