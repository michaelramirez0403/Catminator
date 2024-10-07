//
//  CatInfoVC.swift
//

import UIKit
class CatInfoVC: BaseViewController {
    let viewModel = CatInfoViewModel()
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let bioLabel            = GFSecondaryTitleLabel(fontSize: 20)
    let getStartedButton    = CatButton(backgroundColor: .systemPink, title: "Click me for a surprise.")
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureViewController()
        view.addSubviews(avatarImageView, bioLabel, getStartedButton)
        layoutUI()
        configureUIElements()
    }
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    func configureUIElements() {
        if UserDefaults.standard.object(forKey: TitleAppLabel.CatImage) != nil {
            //Key exists - load local image
            guard let data = UserDefaults.standard.data(forKey: TitleAppLabel.CatImage) else { return }
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            DispatchQueue.main.async {
                self.avatarImageView.image = image
                self.bioLabel.text = self.viewModel.cat?.catdesc ?? "No description available."
            }
        }
    }
    func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 18
        let height: CGFloat             = 50
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(265)
        }
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(textImagePadding)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(100)
        }
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-80)
            make.leading.equalTo(view.snp.leading).offset(padding).offset(height)
            make.trailing.equalTo(view.snp.trailing).offset(-height)
            make.height.equalTo(height)
        }
        bioLabel.numberOfLines = 10
        getStartedButton.addTarget(self, action: #selector(pushCatListVC), for: .touchUpInside)
    }
    @objc func pushCatListVC() {
//        viewModel.getRandomCat()
        let cat = viewModel.randomCat()
        didRequestSuccess(cat)
    }
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}
extension CatInfoVC: CatDelegate {
    func loading() { showLoadingView() }
    func dismiss() { dismissLoadingView() }
    func didRequestSuccess(_ cat: Cat) {
        DispatchQueue.main.async {
            self.loading()
        }
        DispatchQueue.global(qos: .utility).async {
            self.avatarImageView.downloadImage(fromURL: cat.catUrl!)
            DispatchQueue.main.async {
                if let _ = self.avatarImageView.image {
                    self.dismiss()
                }
                self.bioLabel.text = cat.catdesc ?? "No description available."
            }
        }
    }
    func didRequestFailed(error: CatError) {
        DispatchQueue.main.async {
            self.presentGFAlertOnMainThread(title: "Bad Stuff Happened",
                                            message: error.rawValue,
                                            buttonTitle: "Ok")
        }
    }
}
