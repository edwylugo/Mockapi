//
//  MockREST.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation

enum MockError {
    case url
    case taskerror(error: Error)
    case noResponse(error: Error)
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON(error: Error)
}

class MockREST {
    
// Endereço da API
   private static let basePath = "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events"
    
// Arquivo de configurações
   private static let configuration: URLSessionConfiguration = {
       let config = URLSessionConfiguration.default
       // config.allowsCellularAccess = false
       config.httpAdditionalHeaders = ["Content-Type": "application/json"]
       config.timeoutIntervalForRequest = 30.0
       config.httpMaximumConnectionsPerHost = 5
       return config
   }()

// Compartilhar a Sessão URL //URLSession.shared
   private static let session = URLSession(configuration: configuration)
    
      // Carregar dados da entidade Sincronismo (GET)
        class func loadBook(onComplete: @escaping ([Event]) -> Void, onError: @escaping (MockError) -> Void) {
            print("basePath: \(basePath)")
            guard let url = URL(string: basePath) else {
                onError(.url)
                return
            }

            // Criando tarefa
            let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

                if error == nil {
                    // checando objeto de resposta
                    guard let response = response as? HTTPURLResponse else {
                        onError(.noResponse(error: error!))
                        return
                    }

                    if response.statusCode == 200 {
                        guard let data = data else { return }

                        do {
                            let listloadEvent = try JSONDecoder().decode([Event].self, from: data)
                            onComplete(listloadEvent)

                            print("## Lista carregada com sucesso ##")
                            print("\(listloadEvent.count)")

                        } catch {
                            print(error.localizedDescription)
                            onError(.invalidJSON(error: error))
                        }

                    } else {
                        print("Algum status inválido pelo servidor!!")
                        onError(.responseStatusCode(code: response.statusCode))
                    }
                } else {
                    // To sem internet ou Modo Avião
                    onError(.taskerror(error: error!))
                }
            }

            dataTask.resume()
        }
    }
