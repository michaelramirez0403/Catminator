//
//  NetworkManager.swift
//
import UIKit
class NetworkManager {
    //
    // https://meowfacts.herokuapp.com/?count=18
    static let shared   = NetworkManager()
    private let baseURL = "https://meowfacts.herokuapp.com/"
    let cache           = NSCache<NSString, UIImage>()
    private init() { }
    // MARK: OLD WAY of doing it
    //    func getCats(completed: @escaping (Result<CatResponse, CatError>) -> Void) {
    //        let endpoint = baseURL + "?count=\(Collection.limit)"
    //        guard let url = URL(string: endpoint) else {
    //            completed(.failure(.invalidUsername))
    //            return
    //        }
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let _ = error {
    //                completed(.failure(.unableToComplete))
    //                return
    //            }
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completed(.failure(.invalidResponse))
    //                return
    //            }
    //            guard let data = data else {
    //                completed(.failure(.invalidData))
    //                return
    //            }
    //            do {
    //                let decoder = JSONDecoder()
    //                decoder.keyDecodingStrategy = .convertFromSnakeCase
    //                let catsRamdonDescription = try decoder.decode(CatResponse.self, from: data)
    //                completed(.success(catsRamdonDescription))
    //            } catch {
    //                completed(.failure(.invalidData))
    //            }
    //        }
    //        task.resume()
    //    }
    // MARK: - NEW WAY of doing it
    func getCats(completed: @escaping (Result<CatResponse, CatError>) -> Void) {
        Task {
            let endpoint = baseURL + "?count=\(Collection.limit)"
            // Validate URL
            guard let url = URL(string: endpoint) else {
                completed(.failure(.invalidUsername))
                return
            }
            do {
                // Fetch data
                let (data, response) = try await URLSession.shared.data(from: url)
                // Validate response status
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
                }
                // Decode data
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let catResponse = try decoder.decode(CatResponse.self, from: data)
                // Return success
                completed(.success(catResponse))
                
            } catch let decodingError as DecodingError {
                // Handle decoding errors
                switch decodingError {
                case .dataCorrupted:
                    completed(.failure(.invalidData))
                case .keyNotFound:
                    completed(.failure(.invalidData))
                case .typeMismatch:
                    completed(.failure(.invalidData))
                case .valueNotFound:
                    completed(.failure(.invalidData))
                @unknown default:
                    completed(.failure(.invalidData))
                }
            } catch {
                // Handle other errors
                completed(.failure(.unableToComplete))
            }
        }
    }
    // MARK: - Download image
    // MARK: OLD Way of doing it
    //    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
    //        let cacheKey = NSString(string: urlString)
    //        if let image = cache.object(forKey: cacheKey) {
    //            completed(image)
    //            return
    //        }
    //        guard let url = URL(string: urlString) else {
    //            completed(nil)
    //            return
    //        }
    //        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
    //            guard let self = self,
    //                  error == nil,
    //                  let response = response as? HTTPURLResponse, response.statusCode == 200,
    //                  let data = data,
    //                  let image = UIImage(data: data) else {
    //                completed(nil)
    //                return
    //            }
    //            self.cache.setObject(image, forKey: cacheKey)
    //            completed(image)
    //        }
    //        task.resume()
    //    }
    // MARK: NEW Way of doing it
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        // Check cache
        if let cachedImage = cache.object(forKey: cacheKey) {
            return cachedImage
        }
        // Validate URL
        guard let url = URL(string: urlString) else {
            return Images.emptyStateLogo
        }
        do {
            // Fetch data
            let (data, response) = try await URLSession.shared.data(from: url)
            // Validate response and data
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let image = UIImage(data: data) else {
                return Images.emptyStateLogo
            }
            // Cache and return image
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            // Handle error
            print("Failed to download image: \(error)")
            return Images.emptyStateLogo
        }
    }
}
