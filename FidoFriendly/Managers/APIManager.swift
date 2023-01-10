//
//  APIManager.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/8/23.
//

import Foundation


class APIManager {
    let baseURL = "https://api.foursquare.com/v3/places"
    let search = "/search?query=dog-friendly,dogs"
    let byID = "/fsq_id"
    
    static let shared = APIManager()
    
    // basic get request
    func getDogFriendlyResults(completion: @escaping (Places) -> Void) {

        let returnFields = "&fields=fsq_id,name,categories,location,distance,link,description,tel,website,rating"
       
        guard
            let url = URL(string: "\(baseURL)\(search)\(returnFields)&ll=40.64994853980254,-73.9605774290414")
        else { return }
        
        var request = URLRequest(url: url)
        request.setValue("fsq3wER44I2BMZ/3LX+LgxYsaNep8ibuWxm738hSwlh9tKY=", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, _, error) in
            guard let data = data, error == nil else {
                print("broke in the guard")
                return
                
            }
            
            do {
                //print(data)
                let results = try JSONDecoder().decode(Places.self, from: data)
                completion(results)
                //print("results: \(results)")
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
    
    
    func getOneDogFriendlyResult(with id: String, completion: @escaping (DogFriendlyPlace) -> Void) {
       
        guard let url = URL(string: "\(baseURL)\(byID)/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("fsq3wER44I2BMZ/3LX+LgxYsaNep8ibuWxm738hSwlh9tKY=", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let data = data, error == nil else {
                print("broke in the guard")
                return
            }
            
            do {
                //print(data)
                let results = try JSONDecoder().decode(DogFriendlyPlace.self, from: data)
                completion(results)
                //print("single result: \(results)")
            } catch {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
}
