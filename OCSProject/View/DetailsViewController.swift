//
//  DetailsViewController.swift
//  OCSProject
//
//  Created by Anis on 04/11/2021.
//

import UIKit
import SDWebImage
import Combine
import AVFoundation
import AVKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var buttonOnImage: UIButton!
    @IBOutlet private weak var imageUnderButton: UIImageView!
    @IBOutlet private weak var titleDetail: UILabel!
    @IBOutlet private weak var subtitleDetail: UILabel!
    @IBOutlet private weak var pitchDetail: UILabel!
    
    let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        title = viewModel.title
        setElements()
        setPitchDetail()
    }
    
    private func setPitchDetail () {
        viewModel.fetchDetailLink()
        viewModel.$pitchDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else {return}
                self.pitchDetail.text = value
            }
            .store(in: &viewModel.cancellable)
    }
    
    private func setElements () {
        guard let content = viewModel.content else { return }
        titleDetail.text = content.title.first?.value
        subtitleDetail.text = content.subtitle
        imageUnderButton.sd_setImage(with: URLsHelper.urlFromString(content.fullscreenimageurl))
        buttonOnImage.setImage(playButtonImage(), for: .normal)
        buttonOnImage.imageView?.tintColor = .white
        buttonOnImage.imageView?.alpha = 0.8
    }
    
    private func playButtonImage () -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        return UIImage(systemName: "play.fill", withConfiguration: configuration)
    }
    
    @IBAction private func tapOnButton (_ sender: UIButton) {
        presentVideo(with: viewModel.videoLink)
    }
}

extension DetailsViewController: VideoPlayerHelper {
    func presentVideo(with link: String) {
        guard let url = URL(string: link) else {return}
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            let playerItem = AVPlayerItem(url: url)
            let playerVC = AVPlayerViewController()
            let player = AVPlayer(playerItem: playerItem)
            playerVC.player = player
            present(playerVC, animated: true) {
                player.play()
            }
        } catch { }
    }
}

extension DetailsViewController: Storyboardable {
    static var storyboardName: UIStoryboard.Names {
        return .main
    }
}
