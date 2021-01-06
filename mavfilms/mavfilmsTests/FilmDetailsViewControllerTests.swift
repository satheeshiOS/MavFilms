//
//  FilmDetailsViewControllerTests.swift
//  mavfilmsTests
//
//  Created by Satheesh Speed Mac on 06/01/21.
//

import XCTest
@testable import mavfilms

class FilmDetailsViewControllerTests: XCTestCase {

    var filmDetailsViewController = FilmDetailsViewController()
    var searchFilmImdbId = "tt4154664"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetFilmDetails() {
        filmDetailsViewController.getFilmDetails(searchFilmImdbId)
    }
    
    func testMockFilmDetails() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "MockFilmDetails", withExtension: ".json") else {
            XCTFail("Missing file")
            return
        }
        
        let json = try Data(contentsOf: url)
        let film: FilmDetailsModel = try JSONDecoder().decode(FilmDetailsModel.self, from: json)
        
        XCTAssertEqual(film.title, "Mon Oncle")
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
