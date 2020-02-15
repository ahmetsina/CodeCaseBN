//
//  BNAPI.swift
//  CodeCaseBN
//
//  Created by AppLogist on 14.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import Moya

enum BNAPI {
    case products
    case product(_ id: Int)
}

extension BNAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://5e209e06e31c6e0014c60962.mockapi.io/api/")!
    }
    
    var path: String {
        switch self {
            case .products:
                return "products"
            case .product(let id):
                return "products/\(id)"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
