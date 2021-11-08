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
    
    private let bundle = Bundle(for: OCSProjectTests.self)
    private var cancellable: Set<AnyCancellable> = []
    
    private let incorrectData = "error".data(using: .utf8)!

    override func setUpWithError() throws {
        cancellable = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ForSearch() throws {
        
        guard let url = bundle.url(forResource: "FakeSearch", withExtension: "json") else { return XCTAssert(false) }
        let taskPublisher = URLSession.shared.dataTaskPublisher(for: url)
        
        let api = APIFetcher()
        api.searchFrom(taskPublisher: taskPublisher)
        
        api.$searchResult
            .receive(on: DispatchQueue.main)
            .sink { value in
                let manualDecode = self.manualDecodeFromJson(type: Search.self, "FakeSearch", "json")
                XCTAssert(value == manualDecode)
            }
            .store(in: &cancellable)
    }
    
    func test_ForDetail () throws {
        
        guard let url = bundle.url(forResource: "FakeDetail", withExtension: "json") else { return XCTAssert(false) }
        let taskPublisher = URLSession.shared.dataTaskPublisher(for: url)
        
        let api = APIFetcher()
        api.detailFrom(taskPublisher: taskPublisher)
        
        api.$detailResult
            .receive(on: DispatchQueue.main)
            .sink { value in
                let manualDecode = self.manualDecodeFromJson(type: Detail.self, "FakeDetail", "json")
                XCTAssert(value == manualDecode)
            }
            .store(in: &cancellable)
    }
    
    private func  manualDecodeFromJson <T: Decodable> (type: T.Type, _ ressource: String, _ extension: String) -> T {
        do {
            guard let url = bundle.url(forResource: ressource, withExtension: "json") else { return T.self as! T }
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(T.self, from: data)
            return json
        } catch { return T.self as! T }
    }
}
