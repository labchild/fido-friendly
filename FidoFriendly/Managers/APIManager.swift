//
//  APIManager.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/8/23.
//

import Foundation


class APIManager {
    private let baseURL = "https://api.foursquare.com/v3/places"
    private let search = "/search?query=dog-friendly,pets"
    private let apiKey = "fsq3wER44I2BMZ/3LX+LgxYsaNep8ibuWxm738hSwlh9tKY="
    private let returnFields = "&fields=fsq_id,name,categories,location,distance,link,description,tel,website,rating"
    
    static let shared = APIManager()
    
    // basic get request (ALL FROM QUERY)
    func getDogFriendlyResults(lat: Double, long: Double, completion: @escaping (Places) -> Void) {
       
        guard
            let url = URL(string: "\(baseURL)\(search)\(returnFields)&ll=\(lat),\(long)")
        else { return }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, _, error) in
            guard let data = data, error == nil else {
                print("broke in the guard")
                return
                
            }
            
            do {
                
                let results = try JSONDecoder().decode(Places.self, from: data)
                completion(results)
                
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
    
    // get a single record request (BY ID< RETURN 1)
    func getOneDogFriendlyResult(fsqID: String, completion: @escaping (DogFriendlyPlace) -> Void) {
       
        guard let url = URL(string: "\(baseURL)/\(fsqID)") else { return }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let results = try JSONDecoder().decode(DogFriendlyPlace.self, from: data)
                completion(results)
                
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        })
        
        task.resume()
    }
}
