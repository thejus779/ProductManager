import Foundation
import TLogger

class NetworkClient {
    @discardableResult
    public func request(
        url: URL,
        verb: HTTPVerb,
        httpBody: Data?,
        headers: [String: String]?,
        completeOnMainThread: Bool = true,
        completion: @escaping NetworkResultCompletion
    ) -> URLSessionDataTask? {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = verb.rawValue
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = headers

        let task = NetworkClient.session.dataTask(with: urlRequest) { (data, response, error) in
            self.handle(
                response: response,
                data: data,
                error: error,
                onMainThread: completeOnMainThread,
                completion: completion
            )
        }
        task.resume()
        return task
    }
    
    
    private func handle(
        response: URLResponse?,
        data: Data?,
        error: Error?,
        onMainThread: Bool,
        completion: @escaping NetworkResultCompletion
    ) {
        if let error = error {
            guard (error as NSError).code != NSURLErrorCancelled else {
                // the request was cancelled by the user, forget about it
                return
            }
            forwardResult(.error(error), onMainThread: onMainThread, completion: completion)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            forwardResult(.error(PError.unknown), onMainThread: onMainThread, completion: completion)
            return
        }
        guard httpResponse.statusCode >= 200  else {
            forwardResult(.error(PError.serverError), onMainThread: onMainThread, completion: completion)
            return
        }
        var dataResult: Data?
        if let d = data, !d.isEmpty {
            dataResult = d
        } else {
            forwardResult(.error(PError.noData), onMainThread: onMainThread, completion: completion)
        }
        
        forwardResult(.success(data: dataResult), onMainThread: onMainThread, completion: completion)
    }
    
    // MARK: - Thread Helper to forward the result
    private func forwardResult(_ result: NetworkResult, onMainThread: Bool, completion: @escaping NetworkResultCompletion) {
        guard onMainThread else {
            // Not advised to do this, can potentially cause crashes if you updated UI in a background thread
            completion(result)
            return
        }
        guard Thread.current != Thread.main else {
            // Already on main thread forward
            completion(result)
            return
        }
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

// MARK: - Session configurations
extension NetworkClient {
    static var session: URLSession = {
        let sessionConfiguration = NetworkClient.commonSessionConfiguration()
        sessionConfiguration.waitsForConnectivity = true
        return URLSession(configuration: sessionConfiguration)
    }()

    static private func commonSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.shouldUseExtendedBackgroundIdleMode = true
        return sessionConfiguration
    }
}
