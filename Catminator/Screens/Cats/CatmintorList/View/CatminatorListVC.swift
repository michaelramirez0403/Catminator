//
//  CatminatorListVC.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/2/24.
//

import UIKit
import SnapKit
class CatminatorListVC: BaseViewController, CatDelegate {
    let viewModel = CatViewModel()
    var collectionView: UICollectionView!
    var selectedIndex: IndexPath? {
        didSet { push() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        configureUI()
        makeConstrainst()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    override func configureUI() {
        super.configureUI()
        view.backgroundColor = CustomColor.backgroundColor
        title = "Behold my super cats!"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: viewModel.create3ColumnLayout(view: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(CatCell.self,
                                forCellWithReuseIdentifier: CatCell.reuseID)
        collectionView.backgroundColor = CustomColor.backgroundColor
        viewModel.configureDataSource(view: collectionView)
        viewModel.getCats()
    }
    override func push() {
        super.push()
        guard let indexPath = selectedIndex else {
            return
        }
        let index           = indexPath.row
        let cat             = viewModel.cats[index]
        let destVC          = CatInfoVC()
        destVC.cat          = cat
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    // MARK: - CatDelegate
    func loading() { showLoadingView() }
    func dismiss() { dismissLoadingView() }
    func show(_ alert: String) {
        DispatchQueue.main.async {
            self.presentGFAlertOnMainThread(title: "Bad Stuff Happened",
                                            message: alert,
                                            buttonTitle: "Ok")
        }
    }
    func didRequestFailed(error: CatError) {
        DispatchQueue.main.async {
            self.presentGFAlertOnMainThread(title: "Bad Stuff Happened",
                                            message: error.rawValue,
                                            buttonTitle: "Ok")
        }
    }
    func didSelect(_ cat: IndexPath) {
        selectedIndex = cat
    }
}
// MARK: - UICollectionViewDelegate
extension CatminatorListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard viewModel.hasMoreCats, !viewModel.isLoadingMoreCats else { return }
            viewModel.getCats()
        }
    }
}
