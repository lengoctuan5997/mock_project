//
//  AccountViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var avatarUserImageView: UIImageView?
    @IBOutlet weak var accountTableView: UITableView?
    @IBOutlet weak var avatarAccount: UIImageView?
    @IBOutlet weak var containerView: UIView?
    
    let informationCell: String = "informationCell"
    let petPageCell: String = "petPageCell"
    let logOutCell: String = "logOutCell"
    var inforAccount: [String] = ["Name", "Address", "Phone Number"]
    var petPage: [String] = ["Information My Pet", "Health Detail My Pet", "My Favorite"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension AccountViewController {
    private func setupUI() {
        containerView?.applyGradient()
        accountTableView?.delegate = self
        accountTableView?.dataSource = self
        accountTableView?.register(
            UINib(
                nibName: String(describing: InformationTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: informationCell
        )
        accountTableView?.register(
            UINib(
                nibName: String(describing: PetTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: petPageCell
        )
        accountTableView?.register(
            UINib(
                nibName: String(describing: LogOutTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: logOutCell
        )

        let headerTableView = StretchyTableHeaderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: 300
            )
        )
        headerTableView.imageView.image = UIImage(named: "dog_f3")
        accountTableView?.tableHeaderView = headerTableView
        accountTableView?.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        0
    }

    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        return UIView()
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if indexPath.section == 1 && indexPath.row == 0 {
            let inforPetVC = InformationPetViewController(
                nibName: String(
                    describing: InformationPetViewController.self
                ),
                bundle: .main
            )
            navigationController?.pushViewController(inforPetVC, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            let healthBookVC = PetHealthBookViewController(
                nibName: String(
                    describing: PetHealthBookViewController.self
                ),
                bundle: .main
            )
            navigationController?.pushViewController(healthBookVC, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 2 {
            let favoriteVC = FavoriteViewController(
                nibName: String(describing: FavoriteViewController.self),
                bundle: .main
            )
            navigationController?.pushViewController(favoriteVC, animated: true)
        }
        accountTableView?.deselectRow(at: indexPath, animated: true)
    }
}

extension AccountViewController: UITableViewDataSource {
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        3
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch section {
        case 2:
            return 1
        default:
            return 3
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let inforCell = accountTableView?.dequeueReusableCell(
                withIdentifier: informationCell
            ) as? InformationTableViewCell else {
                return UITableViewCell()
            }
            return inforCell
        case 1:
            guard let petPageCell = accountTableView?.dequeueReusableCell(
                withIdentifier: petPageCell
            ) as? PetTableViewCell else {
                return UITableViewCell()
            }
            petPageCell.titlePetPageLabel?.text = petPage[indexPath.row]
            return petPageCell
        default:
            guard let logOutCell = accountTableView?.dequeueReusableCell(
                withIdentifier: logOutCell
            ) as? LogOutTableViewCell else {
                return UITableViewCell()
            }
            return logOutCell
        }
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 50
        default:
            return 40
        }
    }
}

// MARK: - scroll table
extension AccountViewController {
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        let headerTableView = accountTableView?.tableHeaderView as? StretchyTableHeaderView
        headerTableView?.scrollViewDidScroll(scrollView: scrollView)
    }
}
