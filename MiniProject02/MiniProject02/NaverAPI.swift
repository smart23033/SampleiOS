//
//  NaverAPI.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 16..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import Foundation
import Moya

let endpointClosure = { (target: Naver) -> Endpoint<Naver> in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(target)
    return defaultEndpoint.adding(newHttpHeaderFields: ["X-Naver-Client-Id": "sJHZz4NN5MaIyWQknPVz","X-Naver-Client-Secret": "UAnFO2Wq1t"])
}

let naverProvider = MoyaProvider<Naver>(endpointClosure: endpointClosure)

public enum Naver {
    case showMovieInfo(String)
}

extension Naver : TargetType {
    public var sampleData: Data {
        switch self {
        case .showMovieInfo:
            return "nothing to show".utf8Encoded
        }
    }
    
    public var baseURL: URL {
        return URL(string: "https://openapi.naver.com")!
    }
    
    public var path : String {
        switch self {
        case .showMovieInfo:
            return "/v1/search/movie.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .showMovieInfo:
            return .get
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .showMovieInfo(let title):
//            자동으로 인코딩해주기 때문에 필요없다.
//            let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            return ["query":"\(title)", "display":"3", "start":"1"]
        }
    }

    public var task: Task {
        switch self {
        case .showMovieInfo:
            return .request
        }
    }
    
}
