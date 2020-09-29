//
//  SelectorPopTableViewController.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

protocol PopTableEventDelegate: class {
    func dismissWith(variant: Variant)
}

class SelectorPopTableTableViewController: UITableViewController {

    var array = [Variant]()
    
    weak var delegate: PopTableEventDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        let topInset: CGFloat = 12
        tableView.separatorStyle = .none
        tableView.contentInset.top = topInset
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "id - " + String(array[indexPath.row].id) + ": '" + array[indexPath.row].text + "'"
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dismissWith(variant: array[indexPath.row])
    }

}
