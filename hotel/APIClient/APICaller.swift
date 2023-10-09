//
//  APICaller.swift
//  hotel
//
//  Created by Admin on 02.09.2023.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
   
    enum APICallerError: Error {
        case failedToCreateUrl
        case failedToGetData
    }
    
    private init() {}
    
    public func fetchBookingInfo<T: Codable>(request: HotelRequest, expecting type: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let request = self.request(from: request) else {
            completion(.failure(APICallerError.failedToCreateUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("//// \(String(describing: data))")
                completion(.failure(APICallerError.failedToGetData))
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APICallerError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    private func request(from request: HotelRequest) -> URLRequest? {
        guard let url = request.url else {
            print("url request creation failed")
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
