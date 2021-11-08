//
//  OCSProjectTests.swift
//  OCSProjectTests
//
//  Created by Anis on 02/11/2021.
//

import XCTest
import Combine
@testable import OCSProject

class OCSProjectTests: XCTestCase {
    
    private var cancellable: Set<AnyCancellable> = []
    
    let incorrectData = "error".data(using: .utf8)!
    var correctData: Data {
        let bundle = Bundle(for: OCSProject.DetailsViewController.self)
            guard let url = bundle.url(forResource: "FakeJsonResponse", withExtension: "json") else { return Data() }
            return try! Data(contentsOf: url)
        }

    override func setUpWithError() throws {
        cancellable = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func teestExample() throws {
                
        guard let url = Bundle.main.url(forResource: "FakeJsonResponse", withExtension: "json") else {
            XCTAssertFalse(true)
            return }
        
        let taskPublisher = URLSession.shared.dataTaskPublisher(for: url)
        
        let api = APIFetcher()
        api.searchFrom(taskPublisher: taskPublisher)
        
        api.$searchResult
            .sink { value in
                XCTAssert(value.contents?.isEmpty == true)
            }
            .store(in: &cancellable)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
