//
//  APIFetcher.swift
//  OCSProject
//
//  Created by Anis on 02/11/2021.
//

import Foundation
import Combine

class APIFetcher {
    
    @Published var searchResult = Search()
    @Published var detailResult = Detail()
    private var task: AnyCancellable?
    
    private func dataFromURLSession(with url: URL) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: url)
    }
    
    func search (for key: String) {
        var components = URLComponents()
            components.scheme = "https"
            components.host = "api.ocs.fr"
            components.path = "/apps/v2/contents"
            components.queryItems = [
                URLQueryItem(name: "search", value: "title=" + key)
            ]
        guard let url = components.url else { return }
        searchFrom(taskPublisher: dataFromURLSession(with: url))
    }
    
    func searchFrom(taskPublisher: URLSession.DataTaskPublisher) {
        task = taskPublisher // URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: Search.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .replaceError(with: Search())
            .assign(to: \.searchResult, on: self)
    }
    
    func detail (for link: String) {
        var components = URLComponents()
            components.scheme = "https"
            components.host = "api.ocs.fr"
            components.path = link
        guard let url = components.url else { return }
        detailFrom(taskPubliser: dataFromURLSession(with: url))
    }
    
    func detailFrom(taskPubliser: URLSession.DataTaskPublisher) {
        task = taskPubliser
            .first()
            .map{$0.data}
            .decode(type: Detail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .replaceError(with: Detail())
            .assign(to: \.detailResult, on: self)
    }
}
