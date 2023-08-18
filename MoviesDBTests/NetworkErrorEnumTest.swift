//
//  NetworkErrorEnumTest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class NetworkErrorEnumTest: XCTestCase {
    func testNetworkErrorEnums() {
        let error1 = NetworkError.badRequest
        let error2 = NetworkError.failed
        let error3 = NetworkError.invalidRequest
        let error4 = NetworkError.noData
        let error5 = NetworkError.noResponse
        let error6 = NetworkError.unableToDecode
        XCTAssertTrue(error1.description == "Bad Request")
        XCTAssertTrue(error2.description == "Network Request Failed")
        XCTAssertTrue(error3.description == "Invalid Request")
        XCTAssertTrue(error4.description == "Response returned with no data")
        XCTAssertTrue(error5.description == "Response returned with no response")
        XCTAssertTrue(error6.description == "Response couldnot be decoded")
        
        XCTAssertTrue(NetworkError.badRequest.description == "Bad Request")
        
        
        var badRequest: NetworkError { .badRequest }
        XCTAssertEqual(badRequest, .badRequest)
        
        var failed: NetworkError { .failed }
        XCTAssertEqual(failed, .failed)
        
        var invalidRequest: NetworkError { .invalidRequest }
        XCTAssertEqual(invalidRequest, .invalidRequest)
        
        var noData: NetworkError { .noData }
        XCTAssertEqual(noData, .noData)
        
        var noResponse: NetworkError { .noResponse }
        XCTAssertEqual(noResponse, .noResponse)
        
        var unableToDecode: NetworkError { .unableToDecode }
        XCTAssertEqual(unableToDecode, .unableToDecode)
        
        var smallImage: ImageSize { .small }
        XCTAssertEqual(smallImage.url, Configuration.smallImageUrl)
        
        var originalImage: ImageSize { .original }
        XCTAssertEqual(originalImage.url, Configuration.originalImageUrl)

    }

}
