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
        initSearchBar()
        initCollectionView()
        bindDataSource()
    }
    
    private func initSearchBar () {
        searchController = UISearchController(searchResultsController:  nil)
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        searchController.searchBar.becomeFirstResponder()
        navigationItem.titleView = searchController.searchBar
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
        return UIEdgeInsets(top: 10, left: 1, bottom: 5, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 4
        return CGSize(width: collectionViewWidth / 2, height: collectionViewWidth / 2)
        //return CGSize(width: collectionViewWidth, height: collectionViewWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // searchController.isActive = false
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
