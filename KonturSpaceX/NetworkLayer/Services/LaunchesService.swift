//
//  LaunchesService.swift
//  KonturSpaceX
//
//  Created by Sergei Smirnov on 18.04.2024.
//

import Foundation

protocol LaunchesServiceProtocol {
    func fetchLaunches(
        completion: @escaping (Result<[Launches], ApiClientError>) -> Void
    )
}

final class LaunchesService: LaunchesServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchLaunches(
        completion: @escaping (Result<[Launches], ApiClientError>) -> Void
    ) {
        guard let request = makeUrlRequest() else {
            completion(.failure(.empty))
            return
        }
        
        networkClient.fetch(request: request) {
            (result: Result<[Launches], ApiClientError>) in
            switch result {
            case .success(let launches):
                DispatchQueue.main.async {
                    completion(.success(launches))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

private extension LaunchesService {
    func makeUrlRequest() -> URLRequest? {
//    https://api.spacexdata.com/v4/launches
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.spacexdata.com"
        urlComponents.path = "/v4/launches"
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
