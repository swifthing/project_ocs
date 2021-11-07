//
//  SearchViewModel.swift
//  OCSProject
//
//  Created by Anis on 06/11/2021.
//

import Combine
import UIKit

protocol SearchUseCasesProtocol {
    func fetchData()
}

class SearchViewModel: SearchUseCasesProtocol {
    
    @Published var dataSource = [Search.Contents]()
    @Published var keyword: String = "Game"
    var cancellable: Set<AnyCancellable>
    let searchPlaceholder: String = "Mots clés"
    let cellImagePlaceholder: String = "placeholder"
    let cellIdentifier: String = "SearchCollectionViewCell"
    
    init() {
        cancellable = []
        fetchData()
        $keyword
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else {return}
                self.fetchData()
            }
            .store(in: &cancellable)
    }
    
    internal func fetchData () {
        let search = APIFetcher()
        search.search(for: keyword)
        search.$searchResult
            //.receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else {return}
                if let content = value.contents {
                    self.dataSource = content
                }
            }
            .store(in: &cancellable)
    }
}
