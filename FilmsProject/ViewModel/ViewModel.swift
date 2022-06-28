//
//  ViewModel.swift
//  FilmsProject
//
//  Created by info 0033 on 28/06/22.
//

import Foundation
import UIKit

protocol ViewModelDelegate:AnyObject {
    func success()
    func error()
}
class ViewModel{
    
    var data:[People] = []
    
    private var delegate:ViewModelDelegate?
    
    public func delegate(delegate:ViewModelDelegate){
        self.delegate = delegate
    }
    private let service:Service = Service()
    
    public func getPeople(){
        self.service.getPeople { success, error in
            if let success = success{
                self.data = success
                print(success)
                self.delegate?.success()
            }else{
                print(error)
                self.delegate?.error()
            }
        }
    }
    
    public var rowsInSection:Int{
        return data.count
    }
    
    public func loadData(indexPath:IndexPath)-> People{
        return data[indexPath.row]
    }
    
    public var heightForRow:CGFloat{
        return 150.0
    }
    
}
