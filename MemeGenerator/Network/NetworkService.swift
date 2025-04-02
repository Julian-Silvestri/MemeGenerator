//
//  NetworkService.swift
//  MemeGenerator
//
//  Created by Julian Silvestri on 2025-04-02.
//

import Foundation

class NetworkService {
    
    public static let sharedService = NetworkService()
    
    let baseUrl = "https://api.imgflip.com/get_memes"
    
    func getMemes(completionHandler: @escaping(Bool)->Void){
        var urlRequest = URLRequest(url: URL(string: baseUrl)!, timeoutInterval: Double.infinity)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        
            guard let data = data else {
                print("Error occurred => \(String(describing: error))")
                return
            }
            
            do {
                
                let jsonData = try JSONDecoder().decode(MemeModel.self, from: data)
                MemeModel.result.append(MemeModel(success: jsonData.success, data: jsonData.data))
                
                for values in MemeModel.result{
                    print(values.data.memes.count)
                    for data in values.data.memes {
                        MemeModel.dataResults.append(MemeResults(id: data.id, name: data.name, url: data.url, width: data.width, height: data.height, box_count: data.box_count))
                    }
//                    print(values.data.memes.count)
                }
                
//                print(MemeModel.result.count)
//                print(MemeModel.dataResults.count)
//
//                
//                for x in MemeModel.dataResults {
//                    print(x)
//                }
                
//                dump(MemeModel.dataResults.count)
                completionHandler(true)
            } catch let err {
                print("Error occurred => \(err)")
                completionHandler(false)
            }
                
            
        }
        
        task.resume()
        
    }
    
    
}
