//
//  PersonViewController.swift
//  RickAndMortyApp
//
//  Created by info 0033 on 29/06/22.
//

import UIKit

class PersonViewController: UIViewController {
    
    let personVM:PersonViewModel = PersonViewModel()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nameLabel.text = self.personVM.label
    }


}
extension PersonViewController:ViewControllerDelegate{
    func configData(indexPath: IndexPath, data: [People]) {
        self.nameLabel.text = data[indexPath.row].name
    }

    
    
}
