//
//  DetailsViewModel.swift
//  OCSProject
//
//  Created by Anis on 06/11/2021.
//

import Combine

class DetailsViewModel {
    @Published var pitchDetail: String = ""
    let videoLink: String = "https://bitmovin-a.akamaihd.net/content/bbb/stream.m3u8"
    var title: String = "Détails"
    var content: Search.Contents?
    var cancellable: Set<AnyCancellable>
    
    init() {
        cancellable = []
        fetchDetailLink()
    }
    
    func fetchDetailLink () {
        guard let content = content else {return}
        let detail = APIFetcher()
        detail.detail(for: content.detaillink)
        detail.$detailResult
            .sink { [weak self] value in
                guard let self = self else {return}
                if let content = value.contents {
                    self.pitchDetail = content.pitch
                }
            }
            .store(in: &cancellable)
    }
}
