//
//  VAL2TableViewController.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

final
class WAL02TableViewController: UITableViewController {
    
    var didPress:((String) -> Void)?
    
    var variants: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = variants[indexPath.row]
        return cell
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didPress?(variants[indexPath.row])
    }
    
    override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variants.count
    }
    
    override
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
