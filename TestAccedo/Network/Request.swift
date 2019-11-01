//
//  Request.swift
//  TestAccedo
//
//  Created by MacBook Pro on 30/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

protocol ApiClient {
    var session: URLSession { get }
    func fetchData<T: Decodable>(request: URLRequest,
                                 decode: @escaping (Decodable) -> T?,
                                 completion: @escaping (Result<T, ErrorHandler>) -> Void)
}

extension ApiClient {
    typealias TaskCompletion = (Decodable?, ErrorHandler?) -> Void
    
    private func decodingTask<T: Decodable>(request: URLRequest,
                                            decodingType: T.Type,
                                            completion: @escaping TaskCompletion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return }
            if response.statusCode == 200 {
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(decodingType, from: data)
                        completion(model, nil)
                    } catch {
                        print("Error in some parameter struct cannot convert: ", error.localizedDescription)
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    print("Error on data is invalid: ", error?.localizedDescription ?? "")
                    completion(nil, .invalidData)
                }
            } else {
                print("Error in response: ", error?.localizedDescription ?? "")
                completion(nil, .responseUnsuccessfull)
            }
        }
        return task
    }
    
    func fetchData<T: Decodable>(request: URLRequest,
                                 decode: @escaping (Decodable) -> T?,
                                 completion: @escaping (Result<T, ErrorHandler>) -> Void) {
        let task = decodingTask(request: request, decodingType: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.error(error))
                    } else {
                        completion(Result.error(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.error(.jsonConversionFailure))
                }
            }
        }
        task.resume()
    }
}
