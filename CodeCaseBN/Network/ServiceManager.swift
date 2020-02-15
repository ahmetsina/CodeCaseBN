//
//  ServiceManager.swift
//  CodeCaseBN
//
//  Created by AppLogist on 14.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa

import Result

public typealias APIResult<T> = Result<T, Error>

class ServiceManager: NSObject {
    static let shared = ServiceManager()
    let disposeBag = DisposeBag()

    /// Log network data
    static let verbose = true
    
    // MARK: - Provider setup
    
    private let provider = MoyaProvider<BNAPI>(plugins: ServiceManager.plugins)
    
    // Pretty print JSON
    static func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
    
    static var plugins: [PluginType] = {
        [NetworkLoggerPlugin(verbose: verbose,
                             responseDataFormatter: ServiceManager.JSONResponseDataFormatter)]
    }()
    
    private var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }
    
    private func fetch<M: Decodable>(target: BNAPI,
                                     completion: @escaping (_ result: APIResult<M>) -> Void ) {
        provider.rx.request(target).subscribe { (event) in
            self.handleResponse(event, completion: completion)
        }.disposed(by: disposeBag)
    }
    
    private func handleResponse<M: Decodable>(_ result: SingleEvent<Response>,
                                              completion: @escaping (_ result: APIResult<M>) -> Void ) {
        switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filter(statusCodes: 200...401)
                    let mappedResponse = try filteredResponse.map(M.self,
                                                                  atKeyPath: nil,
                                                                  using: jsonDecoder,
                                                                  failsOnEmptyData: false)
                    DispatchQueue.main.async {
                        completion(.success(mappedResponse))
                    }
                } catch MoyaError.statusCode(let response) {
                    completion(.failure(MoyaError.statusCode(response)))
                } catch {
                    debugPrint("##ERROR parsing##: \(error.localizedDescription)")
                    let moyaError = MoyaError.requestMapping(error.localizedDescription)
                    completion(.failure(moyaError))
            }
            case .error(let error):
                debugPrint("##ERROR service:## \(error.localizedDescription)")
                completion(.failure(error))
        }
    }
    
    // MARK: - Products
    func products(completion: @escaping (_ result: APIResult<[BNProduct]>) -> Void) {
        fetch(target: .products , completion: completion)
    }
    
    // MARK: - Product
    func product(_ id: Int, completion: @escaping (_ result: APIResult<BNProduct>) -> Void) {
        fetch(target: .product(id) , completion: completion)
    }
    
}
