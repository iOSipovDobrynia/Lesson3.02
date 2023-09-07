//
//  NetworkManager.swift
//  Lesson3.02
//
//  Created by Goodwasp on 07.09.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

enum Link: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case courseURL = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case coursesURL = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case aboutUsURL = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case aboutUsURL2 = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(fromUrl url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchCourse(fromUrl url: String?) {
        
    }
}
