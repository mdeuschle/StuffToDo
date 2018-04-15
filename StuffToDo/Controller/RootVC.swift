//
//  ViewController.swift
//  StuffToDo
//
//  Created by Matt Deuschle on 4/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class RootVC: UIViewController, AddItemDelegate {

    var items = [Item]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        tableView.rowHeight = 60
    }

    func addItem(item: Item) {
        items.append(item)
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
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configCell(label: item.title)
        return cell
    }
}

