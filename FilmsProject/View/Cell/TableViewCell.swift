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
    
    let urlString:String = "https://rickandmortyapi.com/api/character"
    
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
        self.userImage.clipsToBounds = true
        self.userImage.layer.cornerRadius = userImage.frame.height/2
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
        self.label1.text = "Nome: \(data.name ?? "")"
        self.label2.text = "Tipo: \(data.type ?? "")"
        self.label3.text = "ID: \(data.id ?? 0)"
    }
    
}
