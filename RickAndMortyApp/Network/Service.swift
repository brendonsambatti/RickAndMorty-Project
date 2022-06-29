//
//  Service.swift
//  FilmsProject
//
//  Created by info 0033 on 28/06/22.
//

import Foundation

protocol ServiceDelegate:GenericService{
    func getPeople(completion: @escaping completion<[People]?>)
    func getPhotos(completion: @escaping completion<[People]?>)

}

class Service:ServiceDelegate{    
    
    func getPhotos(completion: @escaping completion<[People]?>) {
        let urlString:String = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let JsonResult = try  JSONDecoder().decode(PeopleResult.self, from: data)
                DispatchQueue.main.async {
                    completion(JsonResult.results, nil)
                }
            } catch {
                completion(nil, Error.errorDescription(message: "deu ruim"))
            }
        }
        task.resume()
    }
    
    func getPeople(completion: @escaping completion<[People]?>) {
        let urlString:String = "https://rickandmortyapi.com/api/character"
        
        guard let url:URL = URL(string: urlString) else {return completion(nil, Error.errorDescription(message: "Error ao tirar opcionalidade da URL"))}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            guard let dataResult = data else {return(completion(nil, Error.errorDescription(message: "Error ao remover opcionalidade do data")))}
            
            let json = try? JSONSerialization.jsonObject(with: dataResult)
            print(json as Any)
            
            guard let response = response as? HTTPURLResponse else {return (completion(nil, Error.errorDescription(message: "Error ao realizar a conversão para o HTTPURLResponse")))}
            
            if response.statusCode == 200{
                do {
                    let model: PeopleResult = try JSONDecoder().decode(PeopleResult.self, from: dataResult)
                    completion(model.results, nil)
                } catch {
                    completion(nil, Error.errorDescription(message: "Deu ruim no parse", error: error))
                }
            }else{
                completion(nil, Error.errorDescription(message: "Deu ruim", error: error))
                
            }
        }
        task.resume()
        
    }
}
