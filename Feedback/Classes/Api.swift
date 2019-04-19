//
//  Api.swift
//  Alamofire
//
//  Created by Lukasz on 06/10/2017.
//

import Foundation
import Moya
import Result

internal enum Api {
    case rate(email: String, score: Int, comment: String)
}

extension Api: TargetType {
    
    internal static let api = MoyaProvider<Api>(plugins: [HttpLogger()])
    
    internal var baseURL: URL { return URL(string: FeedbackConfiguration.Api)! }
    
    internal var path: String {
        switch self {
        case .rate(_,_,_): return ""
        }
    }
    
    internal var method: Moya.Method {
        switch self {
        case .rate(_,_,_): return .post
        }
    }
    
    internal var task: Moya.Task {
        switch self {
            
        case .rate(let email, let score, let comment): return .requestParameters(parameters: [
            "email": email,
            "score": score,
            "comment": comment,
            "os": "ios"
            ], encoding: URLEncoding.default)
        }
    }
    
    internal var headers: [String : String]? {
        return nil
    }
    
    internal var sampleData: Data { return Data() }
}


internal class HttpLogger: PluginType {
    
    private func requestLabel(_ request: URLRequest) -> String {
        let url = request.url!.absoluteString
        let path = url.substring(from: url.index(url.startIndex, offsetBy: FeedbackConfiguration.Api.count))
        return "\(request.httpMethod!) \(path)"
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("HTTP -> \(requestLabel(request.request!))")
        if let data = request.request!.httpBody {
            print(String(data: data, encoding: .utf8)!)
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if let value = result.value {
            print("HTTP <- \(requestLabel(value.request!)) [\(value.statusCode)]")
        } else {
            print("HTTP <- FAILED/CANCELED")
        }
    }
}
