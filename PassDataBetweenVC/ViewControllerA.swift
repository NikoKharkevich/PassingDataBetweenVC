//
//  ViewController.swift
//  PassDataBetweenVC
//
//  Created by Nikola Kharkevich on 24.05.2022.
//

import UIKit

class ViewControllerA: UIViewController {
    
    @IBOutlet weak var textFieldA: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    var items = ["India", "Brazil", "France"]
    var selectedIndexA: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toB" {
            guard let destination = segue.destination as? ViewControllerB else { return }
            destination.text = textFieldA.text
            destination.delegate = self
        }
        else if segue.identifier == "toDetails" {
            guard let destination = segue.destination as? TableDetails else { return }
            guard let index = myTableView.indexPathForSelectedRow?.row else { return }
            destination.text = items[index]
            selectedIndexA = index
            destination.delegate = self
        }
    }
}

extension ViewControllerA: ViewControllerBDelegate {
    func textChanged(text: String?) {
        textFieldA.text = text
        print("ViewControllerBDelegate called")
    }
}

extension ViewControllerA: TableDetailsTextDelegate {
    func textDetailsChanged(text: String?) {
        items[selectedIndexA ?? 1] = text!
        print("TableDetailsTextDelegate called")
        self.myTableView.reloadData()
    }
}

extension ViewControllerA: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
        
    }
}

