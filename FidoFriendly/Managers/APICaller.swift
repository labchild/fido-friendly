//
//  APICaller.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/8/23.
//

import Foundation


class APICaller {
    static let shared = APICaller()
    
    // basic get request
    func getDogFriendlyResults(completion: @escaping (String) -> Void) {

        let myUrlString = "https://api.foursquare.com/v3/places/search?query=dog-friendly&fields=website,name&ll=40.64994853980254,-73.9605774290414"
       
        guard let url = URL(string:myUrlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("fsq3wER44I2BMZ/3LX+LgxYsaNep8ibuWxm738hSwlh9tKY=", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Places.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
