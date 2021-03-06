//
//  ViewController.swift
//  100DaySwift HomeWork6.1
//
//  Created by Роман Зобнин on 17.05.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavBar()
    }
    
    func settingNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
        toolbarItems = [spacer, refresh]
        navigationController?.isToolbarHidden = false
        navigationItem.title = "Shop list"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    @objc func add() {
        let AC = UIAlertController(title: "Новая запись", message: "Введите продукт...", preferredStyle: .alert)
        AC.addTextField()
        AC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let addProduct = UIAlertAction(title: "Добавить", style: .default) { [weak self, weak AC] action in
            guard let product = AC?.textFields?[0].text else {return}
            self?.submit(product)
            self?.tableView.reloadData()
        }
        
        AC.addAction(addProduct)
        present(AC, animated: true)
    }
    func submit (_ answer: String) {
        let lowerAnswer = answer.capitalized
        array.insert(lowerAnswer, at: 0)
    }
    
    @objc func share() {
        let list = array.joined(separator: ", ")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func clearList() {
        array.removeAll()
        tableView.reloadData()
    }
}

