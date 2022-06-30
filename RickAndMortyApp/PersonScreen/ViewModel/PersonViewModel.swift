//
//  PersonViewModel.swift
//  RickAndMortyApp
//
//  Created by Brendon Sambatti on 30/06/22.
//

import Foundation
import UIKit

class PersonViewModel{
    
    let service:Service = Service()
    
    var photos:[People] = []
    
    public func getPhotos(){
        self.service.getPhotos { success, error in
            if let success = success{
                self.photos = success
            }else{
                print("Error")
            }
        }
    }
    
    func configure(with urlString:String, userImage:UIImageView?){
        guard let url = URL(string: urlString) else {
            return
        }
        let task =  URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                 let image = UIImage(data: data)
                userImage?.image = image
            }
        }
        task.resume()
    }
    
    func configureImage(image:UIImageView){
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = image.frame.height / 2
    }
    
}
