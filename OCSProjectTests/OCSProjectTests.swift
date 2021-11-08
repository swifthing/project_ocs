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
                let manualDecode = self.manualDecodeFromJsonForSearch()
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
                let manualDecode = self.manualDecodeFromJsonForDetail()
                XCTAssert(value == manualDecode)
            }
            .store(in: &cancellable)
    }
    
    private func manualDecodeFromJsonForSearch () -> Search {
        do {
            guard let url = bundle.url(forResource: "FakeSearch", withExtension: "json") else { return Search() }
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(Search.self, from: data)
            return json
        } catch { return Search() }
    }
    
    private func manualDecodeFromJsonForDetail () -> Detail {
        do {
            guard let url = bundle.url(forResource: "FakeDetail", withExtension: "json") else { return Detail() }
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(Detail.self, from: data)
            return json
        } catch { return Detail() }
    }
}
