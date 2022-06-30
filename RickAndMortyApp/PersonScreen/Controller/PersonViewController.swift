//
//  PersonViewController.swift
//  RickAndMortyApp
//
//  Created by info 0033 on 29/06/22.
//

import UIKit

class PersonViewController: UIViewController {

    let personViewModel:PersonViewModel = PersonViewModel()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var personImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personViewModel.getPhotos()
        self.personViewModel.configureImage(image: self.personImage)
    }
    
    @IBAction func tappedBackButton(){
        dismiss(animated: true, completion: nil)
    }


}
