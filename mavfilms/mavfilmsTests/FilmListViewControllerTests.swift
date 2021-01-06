//
//  FilmListViewControllerTests.swift
//  mavfilmsTests
//
//  Created by Satheesh Speed Mac on 06/01/21.
//

import XCTest
@testable import mavfilms

class FilmListViewControllerTests: XCTestCase {
    
    var filmListViewController = FilmListViewController()
    
    var moviesModel = [Search]()
    
    override func setUpWithError() throws {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testGetFilmList() {
        filmListViewController.getFilmList("mon")
    }
    
    func testReload() {
        filmListViewController.reload("Mon")
    }
    
    func testMockFilmData() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "MockFilmData", withExtension: ".json") else {
            XCTFail("Missing file")
            return
        }
        
        let json = try Data(contentsOf: url)
        let film: FilmModel = try JSONDecoder().decode(FilmModel.self, from: json)
        
        XCTAssertEqual(film.search?[0].title, "Captain Marvel")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
