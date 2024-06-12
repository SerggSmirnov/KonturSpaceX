//
//  RocketService.swift
//  KonturSpaceX
//
//  Created by Sergei Smirnov on 18.04.2024.
//

import Foundation

protocol RocketServiceProtocol {
    func fetchRockets(
        completion: @escaping (Result<[Rockets], ApiClientError>) -> Void
    )
}

final class RocketService: RocketServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchRockets(
        completion: @escaping (Result<[Rockets], ApiClientError>) -> Void)
    {
        guard let request = makeUrlRequest() else {
            completion(.failure(.request))
            return
        }
        
        networkClient.fetch(
            request: request
        ) { (result: Result<[Rockets], ApiClientError>) in
            
            switch result {
            case .success(let rockets):
                DispatchQueue.main.async {
                    completion(.success(rockets))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

private extension RocketService {
    func makeUrlRequest() -> URLRequest? {
//    https://api.spacexdata.com/v4/rockets
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.spacexdata.com"
        urlComponents.path = "/v4/rockets"
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
