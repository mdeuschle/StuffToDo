//
//  AddStuffVC.swift
//  StuffToDo
//
//  Created by Matt Deuschle on 4/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

protocol AddItemDelegate {
    func add(item: Item)
}

import UIKit

class AddStuffVC: UIViewController {

    @IBOutlet weak var itemTextView: UITextView?

    var addItemDelegate: AddItemDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddItemButton()
    }

    init(addItemDelgate: AddItemDelegate) {
        self.addItemDelegate = addItemDelgate
        super.init(nibName: "AddStuffVC", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setUpAddItemButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        navigationItem.rightBarButtonItem = button
    }

    @objc private func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let textView = itemTextView,
            let text = textView.text,
            let item = Item(title: text) else {
                return
        }
        if !text.isEmpty {
            addItemDelegate?.add(item: item)
            navigationController?.popViewController(animated: true)
        }
    }
}
