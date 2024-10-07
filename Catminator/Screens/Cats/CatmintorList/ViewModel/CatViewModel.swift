//
//  CatViewModel.swift
//
import UIKit
class CatViewModel: BaseViewModel  {
    enum Section {
        case main
    }
    var isLoadingMoreCats: Bool = false
    var hasMoreCats: Bool = true
    var cats: [Cat] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Cat>!
    func getCats() {
        self.delegate?.loading()
        isLoadingMoreCats = true
        NetworkManager.shared.getCats { [weak self] result in
            guard let self = self else { return }
            if case .success(let items) = result {
                self.delegate?.dismiss()
                self.cats = items.response?.enumerated().map { index, desc in
                    let randomString = String().randomString(of: Collection.randomStringLength)
                    return Cat(id: index,
                               catdesc: desc,
                               catUrl: "\(Images.ramdomCatUrl)?_id=\(randomString)")
                } ?? []
                self.isLoadingMoreCats = false
                self.updateDateSource(self.cats.uniqued())
            } else if case .failure(let error) = result {
                switch error {
                case .invalidUsername, .invalidResponse,.invalidData, .unableToComplete:
                    self.delegate?.didRequestFailed(error: .unableToComplete)
                case .unableToFavorite, .alreadyInFavorites: break
                }
            }
        }
    }
    // MARK: - CollectionView DataSource
    func create3ColumnLayout(view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, 
                                                       bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth)
        
        return flowLayout
    }
    func configureDataSource(view: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Section, Cat>(collectionView: view, cellProvider: { (collectionView, indexPath, cat) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCell.reuseID, for: indexPath) as! CatCell
            cell.delegate = self
            cell.set(cat, setIndex: indexPath)
            return cell
        })
    }
    func updateDateSource(_ cats: [Cat]) {
        if cats.count > Collection.limit {
            self.hasMoreCats = false
            let message = "I only have \(Collection.limit) cats. Go home and live your life 😀."
            self.delegate?.show(message)
            return
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cat>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cats)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    private func savePhoto(_ cat: UIImage) {
        guard let data = cat.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: TitleAppLabel.CatImage)
        print("Saved Random Cat Image.")
    }
}
//
extension CatViewModel: CatCellDelegate {
    func didSelectCat(_ catImage: UIImage!, setIndex: IndexPath) {
        savePhoto(catImage!)
        delegate?.didSelect(setIndex)
    }
}
