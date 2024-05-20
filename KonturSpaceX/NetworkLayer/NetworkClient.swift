//
//  NetworkClient.swift
//  KonturSpaceX
//
//  Created by Sergei Smirnov on 17.04.2024.
//

import Foundation

enum ApiClientError: Error {
    /// Ошибка создания запроса
    case request
    /// Ошибка сети - нет интернета или ресурс забанен
    case network
    /// Пустой ответ от сервера, при этом все ok
    case empty
    /// Ошибка сервера 40x, 50x, 60x и тп
    case service(_ code: Int)
    /// Ошибка десериализации данных
    case deserialize(_ error: Error)
}

protocol NetworkClientProtocol {
    func fetch<T: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<T, ApiClientError>) -> Void
    )
}

final class NetworkClient: NetworkClientProtocol {
    func fetch<T: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<T, ApiClientError>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in

            if let error = error as? URLError,
               error.code == .notConnectedToInternet
            {
                completion(.failure(.network))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.service(0))) // 0 - неизвестная ошибка сервера
                return
            }

            if !(200 ..< 300).contains(httpResponse.statusCode) {
                completion(.failure(.service(httpResponse.statusCode)))
                return
            }

            guard let data else {
                completion(.failure(.empty))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.deserialize(error)))
            }
        }
        task.resume()
    }
}
