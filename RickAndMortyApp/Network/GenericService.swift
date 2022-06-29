//
//  GenericService.swift
//  FilmsProject
//
//  Created by info 0033 on 28/06/22.
//

import Foundation

protocol GenericService:AnyObject {
    typealias completion <T> = (_ result: T,_ failure: Error?)->Void
}

enum Error:Swift.Error{
    case errorDescription(message:String, error:Swift.Error? = nil)
}
