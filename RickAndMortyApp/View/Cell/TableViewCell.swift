//
//  TableViewCell.swift
//  FilmsProject
//
//  Created by info 0033 on 28/06/22.
//

import UIKit

class TableViewCell: UITableViewCell {
        
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    let personViewModel:PersonViewController = PersonViewController()
    
    let urlString:String = "https://rickandmortyapi.com/api/character/?page=\(0)"
    
    private var delegate:ViewModelDelegate?
    
    public func delegate(delegate:ViewModelDelegate){
        self.delegate = delegate
    }
    static let identifier:String = "TableViewCell"
    static func nib()->UINib{
        return UINib.init(nibName: self.identifier, bundle: nil)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userImage.contentMode = .scaleAspectFill
        self.userImage.clipsToBounds = true
        self.userImage.layer.cornerRadius = userImage.frame.height / 2
    }
    
    func configure(with urlString:String){
        guard let url = URL(string: urlString) else {
            return
        }
        let task =  URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                 let image = UIImage(data: data)
                self?.userImage.image = image
                self?.delegate?.success()
            }
        }
        task.resume()
    }
    
    func setupCell(data:People){

        if data.type == ""{
            self.label1.text = "\(data.name )"
        }else{
            self.label1.text = "\(data.name )"

        }
    }

    
}
