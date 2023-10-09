//
//  ImageManager.swift
//  hotel
//
//  Created by Admin on 07.09.2023.
//

import Foundation

final class ImageManager {
    
    static let shared = ImageManager()
    
    private var imageCache = NSCache<NSString, NSData>()
    
    public func downloadImage(with url: URL?, completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let url = url else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        let key = url.absoluteString as NSString
        if let data = imageCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            
            self?.imageCache.setObject(value, forKey: key)
            completion(.success(data))
            
        }
        task.resume()
        
    }
}
