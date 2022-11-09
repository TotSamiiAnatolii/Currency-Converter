//
//  RatesAPI.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import Foundation

struct RatesAPI {
    
    let url = "https://www.cbr-xml-daily.ru/daily_json.js"

    func getRates(completion:@escaping([String: Valute], DateModel)->()) {
        
        guard let url = URL(string: url) else {return}
        
        let request = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...300:
                    print("Status: \(response.statusCode)")
                default:
                    print("Status: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return }
            
            do {
                let rates = try JSONDecoder().decode(RatesModelDTO.self, from: data)
                let date = try JSONDecoder().decode(DateModel.self, from: data)
                completion(rates.valute , date)
                
            } catch (let error) {
                print(error)
            }
        }
        task.resume()
    }
}
