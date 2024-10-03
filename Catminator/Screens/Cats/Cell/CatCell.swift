//
//  FollowerCell.swift
//  GGFApp
//
//  Created by Macky Ramirez on 9/3/24.
//
import UIKit
import SnapKit
protocol CatCellDelegate: AnyObject {
    func didSelectCat(_ catImage: UIImage!, setIndex: IndexPath)
}
class CatCell: UICollectionViewCell {
    weak var delegate: CatCellDelegate?
    static let reuseID = "CatCell"
    let padding = 8
    let avatarImageView = GFAvatarImageView(frame: .zero)
    var index: IndexPath?
    let button: UIButton = {
        let button = UIButton()
        button.setTitle(blank_, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
        let image = avatarImageView.image
        delegate?.didSelectCat(image, setIndex: index!)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(_ cat: Cat, setIndex: IndexPath) {
        avatarImageView.downloadImage(fromURL: cat.catUrl!)
        index = setIndex
    }
    private func configure() {
        addSubview(avatarImageView)
        addSubview(button)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(padding)
            make.leading.equalTo(self.snp.leading).offset(padding)
            make.trailing.equalTo(self.snp.trailing).offset(-padding)
            make.height.equalTo(avatarImageView.snp.width)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(padding)
            make.leading.equalTo(self.snp.leading).offset(padding)
            make.trailing.equalTo(self.snp.trailing).offset(-padding)
            make.height.equalTo(avatarImageView.snp.width)
        }
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
    }
}
