//
//  TableDetails.swift
//  PassDataBetweenVC
//
//  Created by Nikola Kharkevich on 24.05.2022.
//

import UIKit

protocol TableDetailsTextDelegate: AnyObject {
    func textDetailsChanged(text: String?)
}

class TableDetails: UIViewController {

    var text: String?
    weak var delegate: TableDetailsTextDelegate?
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBAction func uppercasedPressed(_ sender: UIButton) {
        detailsLabel.text = detailsLabel.text?.uppercased()
        delegate?.textDetailsChanged(text: detailsLabel.text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func lowercasedPressed(_ sender: UIButton) {
        detailsLabel.text = detailsLabel.text?.lowercased()
        delegate?.textDetailsChanged(text: detailsLabel.text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailsLabel.text = text
    }

}
