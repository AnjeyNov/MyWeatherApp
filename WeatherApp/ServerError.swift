//
//  ServerError.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import Foundation

struct ServerError: Decodable, Error {
    private let originCode: Int?
    let message: String
    
    static let somethingWentWrong = ServerError(message: .somethingWentWrong)
    static let dataParsingError = ServerError(message: .dataParsingError)
    
    enum CodingKeys: String, CodingKey {
        case reason
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.message = (try? container.decodeIfPresent(String.self, forKey: .reason)) ?? .somethingWentWrong
        self.originCode = nil
    }

    init(message: String) {
        self.message = message
        originCode = nil
    }

    init(fromError error: Error) {
        if let serverError = error as? ServerError {
            self = serverError
            return
        }
        self.originCode = error._code
        self.message = ServerError.isNoConnectionError(error._code) ? .looksLikeConnectionIsOffline : error.localizedDescription
    }

    private static func isNoConnectionError(_ code: Int) -> Bool {
        return [NSURLErrorTimedOut,
                NSURLErrorCannotConnectToHost,
                NSURLErrorNetworkConnectionLost,
                NSURLErrorResourceUnavailable,
                NSURLErrorNotConnectedToInternet,
                NSURLErrorBadServerResponse,
                NSURLErrorDataNotAllowed]
            .contains(code)
    }
}

fileprivate extension String {
    static var reason: String { "reason" }
    static var somethingWentWrong: String { "Something went wrong" }
    static var looksLikeConnectionIsOffline: String { "Looks like connection is offline" }
    static var dataParsingError: String { "Data parsing error" }
}
