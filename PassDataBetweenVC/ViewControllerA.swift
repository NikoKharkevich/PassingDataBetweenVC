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
    
    @IBAction func showBpressed(_ sender: UIButton) {
        guard let viewControllerB = storyboard?.instantiateViewController(withIdentifier: "ViewControllerB") as? ViewControllerB else { return }
        viewControllerB.text = textFieldA.text
        viewControllerB.delegate = self
        present(viewControllerB, animated: true)
    }
    
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
    
}

extension ViewControllerA: ViewControllerBDelegate {
    func textChanged(text: String?) {
        textFieldA.text = text
        print("ViewControllerBDelegate called")
    }
}

extension ViewControllerA: TableDetailsTextDelegate {
    func textDetailsChanged(text: String?) {
        items[selectedIndexA!] = text!
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
        
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "TableDetails") as? TableDetails else { return }
        selectedIndexA = indexPath.row
        detailsVC.text = items[selectedIndexA!]
        detailsVC.delegate = self

        present(detailsVC, animated: true)
    }
}

