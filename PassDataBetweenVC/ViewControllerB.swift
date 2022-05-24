//
//  ViewControllerB.swift
//  PassDataBetweenVC
//
//  Created by Nikola Kharkevich on 24.05.2022.
//

import UIKit

protocol ViewControllerBDelegate: AnyObject {
    func textChanged(text: String?)
}

class ViewControllerB: UIViewController {
    
    var text: String?
    weak var delegate: ViewControllerBDelegate?
    @IBOutlet weak var labelB: UILabel!
    
    @IBAction func uppercasedPressed(_ sender: UIButton) {
        labelB.text = labelB.text?.uppercased()
        delegate?.textChanged(text: labelB.text)
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func lowercasedPressed(_ sender: UIButton) {
        labelB.text = labelB.text?.lowercased()
        delegate?.textChanged(text: labelB.text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelB.text = text
    }
  
}
