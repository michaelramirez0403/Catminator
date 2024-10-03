//
//  ViewController.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/2/24.
//

import UIKit
import SnapKit
class CatminatorLandingVC: BaseViewController {
    let logoImageView = UIImageView()
    let titleLabel   = GFTitleLabel(textAlignment: .left, fontSize: 32)
    let getStartedButton  = CatButton(backgroundColor: .systemPink, title: "Let's get started.")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        makeConstrainst()
    }
    override func configureUI() {
        super.configureUI()
        view.backgroundColor = CustomColor.backgroundColor
        view.addSubviews(logoImageView,
                         titleLabel,
                         getStartedButton)
        configureLogoImageAndTextLabelView()
        configureCallToActionButton()
    }
    override func makeConstrainst() {
        super.makeConstrainst()
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        let padding: CGFloat = 50
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(topConstraintConstant + 30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(200)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(topConstraintConstant)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-80)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(padding)
        }
    }
    override func push() {
        super.push()
    }
    func configureLogoImageAndTextLabelView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.catLogo
        titleLabel.text = TitleAppLabel.titleApp
    }
    func configureCallToActionButton() {
        getStartedButton.addTarget(self, action: #selector(pushCatListVC), for: .touchUpInside)
    }
    @objc func pushCatListVC() {
        let catListVC = CatminatorListVC()
        navigationController?.pushViewController(catListVC, animated: true)
    }
}

