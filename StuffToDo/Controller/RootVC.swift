//
//  ViewController.swift
//  StuffToDo
//
//  Created by Matt Deuschle on 4/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class RootVC: UIViewController, AddItemDelegate {

    // MARK: Properties
    private var items = [Item]()
    private var filteredItems = [Item]()
    private var isFiltering = false

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        setUpSearchController()
        items = Dao().unArchiveItems() ?? [Item]()
    }

    // MARK: Private Methods
    private func setupCell() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        tableView.rowHeight = 60
    }

    private func loadItems() {
        items = Dao().unArchiveItems() ?? [Item]()
        tableView.reloadData()
    }

    // MARK: Delegate Methods
    func add(item: Item) {
        items.append(item)
        Dao().archive(items: items)
        tableView.reloadData()
    }
    
    @IBAction func addStuffButtonTapped(_ sender: UIBarButtonItem) {
        let addStuffVC = AddStuffVC(addItemDelgate: self)
        addStuffVC.addItemDelegate = self
        navigationController?.pushViewController(addStuffVC, animated: true)
    }
}

extension RootVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredItems.count : items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        let item = isFiltering ? filteredItems[index] : items[index]
        cell.configCell(label: item.title)
        return cell
    }
}

extension RootVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items.remove(at: indexPath.row)
        Dao().archive(items: items)
        tableView.reloadData()
    }
}

extension RootVC: UISearchControllerDelegate {

    private func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

extension RootVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            isFiltering = true
            filteredItems = items.filter { $0.title.lowercased().contains(text.lowercased()) }
        } else {
            isFiltering = false
            filteredItems = [Item]()
        }
        tableView.reloadData()
    }
}








