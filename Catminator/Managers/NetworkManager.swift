//
//  NetworkManager.swift
//
import UIKit
class NetworkManager {
    //
    // https://meowfacts.herokuapp.com/?count=18
    static let shared   = NetworkManager()
    private let baseURL = "https://meowfacts.herokuapp.com/"
    private init() { }
    func getRandomCat(completed:@escaping (Result<CatResponse, CatError>) -> Void) {
        let endpoint = baseURL
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let catsRamdonDescription = try decoder.decode(CatResponse.self, from: data)
                completed(.success(catsRamdonDescription))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    func getCats(completed: @escaping (Result<CatResponse, CatError>) -> Void) {
        let endpoint = baseURL + "?count=18"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let catsRamdonDescription = try decoder.decode(CatResponse.self, from: data)
                completed(.success(catsRamdonDescription))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    // MARK: - Download image
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            completed(image)
        }
        task.resume()
    }
}
