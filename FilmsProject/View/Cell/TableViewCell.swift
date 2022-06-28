//
//  TableViewCell.swift
//  FilmsProject
//
//  Created by info 0033 on 28/06/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    static let identifier:String = "TableViewCell"
    static func nib()->UINib{
        return UINib.init(nibName: self.identifier, bundle: nil)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(data:People){
        self.label1.text = data.name ?? "sem info"
        self.label2.text = data.type ?? "sem info"
        self.label3.text = data.created ?? "sem info"
        self.userImage.image = UIImage(named: data.image ?? "")
    }
    
}
