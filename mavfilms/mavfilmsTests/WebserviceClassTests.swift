//
//  WebserviceClassTests.swift
//  mavfilmsTests
//
//  Created by Satheesh Speed Mac on 06/01/21.
//

import XCTest
@testable import mavfilms
import Alamofire

class WebserviceClassTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilmDetailsApiCall() {
        
        var filmDetails:FilmDetailsModel!
        
        let urlString = "http://www.omdbapi.com/?apikey=b9bd48a6&i=tt0050706"
        
        let exp = expectation(description: "Load Film Details")
        
        WebserviceClass.sharedAPI.performRequest(type: FilmDetailsModel.self, urlString: urlString) { (response) in
            filmDetails = response
            print("success data")
            exp.fulfill()
        } failure: { (response) in
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
        
        XCTAssertNotEqual(filmDetails.title, nil)

        
    }
    
    func testFilmListApiCall() {
        
        var filmModel: FilmModel!
        
        let urlString = "http://www.omdbapi.com/?apikey=b9bd48a6&s=Marvel&type=movie"
        
        let exp = expectation(description: "Load Film Details")
        
        WebserviceClass.sharedAPI.performRequest(type: FilmModel.self, urlString: urlString) { (response) in
            filmModel = response
            print("success data")
            exp.fulfill()
        } failure: { (response) in
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
        
        XCTAssertNotEqual(filmModel.search?[0].title, nil)

        
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
