//
//  SearchViewController.swift
//  OCSProject
//
//  Created by Anis on 02/11/2021.
//

import UIKit
import Combine
import SDWebImage

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageDetails: UIImageView!
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var searchController: UISearchController!
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLogoOnTitleView()
        initStatusBarColor()
        initSearchBar()
        initCollectionView()
        bindDataSource()
    }
    
    private func initStatusBarColor () {
        let statusBar = UIView(frame: (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame)!)
        statusBar.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        UIApplication.shared.windows.first?.addSubview(statusBar)
    }
    
    private func initSearchBar () {
        searchController = UISearchController(searchResultsController:  nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        searchController.searchBar.becomeFirstResponder()
        navigationItem.backButtonTitle = ""
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.textColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func initLogoOnTitleView () {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "ocs_titleView")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    private func bindDataSource () {
        viewModel.$dataSource
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.collectionView.reloadData()
            }
            .store(in: &viewModel.cancellable)
    }
    
    private func initCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 1  else { return }
        viewModel.keyword = searchText
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath) as! SearchCollectionViewCell
        let items = viewModel.dataSource[indexPath.row]
        cell.title.text = items.title.first?.value
        cell.imageDetails.sd_setImage(with: URLsHelper.urlFromString(items.imageurl), placeholderImage: UIImage(named: viewModel.cellImagePlaceholder))
        return cell
    }
}

extension SearchViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 4, bottom: 5, right: 4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 16
        return CGSize(width: collectionViewWidth / 2, height: collectionViewWidth / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NavigationRouter.pushViewController(ofType: DetailsViewController.self, on: self) { detailViewController in
            detailViewController.viewModel.content = self.viewModel.dataSource[indexPath.row]
        }
    }
}

extension SearchViewController: Storyboardable {
    static var storyboardName: UIStoryboard.Names {
        return .main
    }
}
