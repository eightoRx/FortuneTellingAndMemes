//
//  NetworkData.swift
//  FortuneTellingAndMemes
//
//  Created by Pavel Kostin on 06.06.2024.
//

import Foundation
import UIKit


enum NetworkError: Error {
    case decodingError
    case noData
    
    var title: String {
        switch self {
            case .decodingError:
            return "Can't decode data"
            case .noData:
            return "Can't fetch data"
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL: URL = URL(string: "https://api.imgflip.com/get_memes")!
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private init() {}
    
    
    public func fetchMemes(completion: @escaping (Result<[Meme], NetworkError>) -> ()) {
        URLSession.shared.dataTask(with: URLRequest(url: baseURL)) { data, _, error in
            
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                sendFailure(with: .noData)
                return
            }
            
            do {
                let memesQuery = try self.decoder.decode(Welcome.self, from: data)
                completion(.success(memesQuery.data.memes))
                
            } catch {
                sendFailure(with: .decodingError)
            }
            
            func sendFailure(with error: NetworkError) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    public func fetchMemeImage(from meme: Meme, completion: @escaping (UIImage) -> ()) {
        
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: meme.url) else { return }
            DispatchQueue.main.async {
                completion( UIImage(data: imageData)! )
            }
        }
    }
}
