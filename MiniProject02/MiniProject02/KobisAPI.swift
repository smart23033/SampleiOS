//
//  KobisAPI.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 16..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import Foundation
import Moya

let kobisProvider = MoyaProvider<Kobis>()

public enum Kobis {
    case showBoxOffice
}

extension Kobis : TargetType {
    public var sampleData: Data {
        switch self {
        case .showBoxOffice:
            return "nothing to show".utf8Encoded
        }
    }

    public var baseURL: URL { return URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest")!}
    
    public var path : String {
        switch self {
        case .showBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    public var method: Moya.Method {
            return .get
    }
    
    public var parameters: [String : Any]? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let yesterday = NSDate().addingTimeInterval(-24 * 60 * 60)
        let convertedDate = dateFormatter.string(from: yesterday as Date)
        
        switch self {
        case .showBoxOffice:
            return ["key":"dd511a8aba40b8ffdfef0fd2ef9f4a1c", "targetDt":convertedDate]
        }
    }
    
    public var task: Task {
        switch self {
        case .showBoxOffice:
            return .request
        }
    }

}

// MARK: - Helpers
public extension String {
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

