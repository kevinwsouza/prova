//
//  Service.swift
//  teste
//
//  Created by Kevin willian Jorge souza on 19/03/21.
//

import Foundation


class Service {
    
    //Contém erros pois ainda não existe o Model criado
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "Application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    func loadData(onComplete: @escaping ([Numbers]?) -> Void) {
        
        guard let url = URL(string: "https://605119cd53460900176712ec.mockapi.io/teste") else {
            onComplete(nil)
            return
        }
        let dataTask = Service.session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                if response.statusCode == 200{
                    guard let data = data else {return}
                    do {
                        let model = try JSONDecoder().decode([Numbers].self, from: data)
                        onComplete(model)
                    } catch {
                        print(error.localizedDescription)
                        onComplete(nil)
                    }
                    
                } else {
                    print("Erro ao realizar a requisição")
                    onComplete(nil)
                }
                
            } else {
                onComplete(nil)
            }
        }
        dataTask.resume()
    }
}
