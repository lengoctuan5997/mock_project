//
//  AccountViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AccountViewController: UIViewController {
    @IBOutlet weak var avatarUserImageView: UIImageView?
    @IBOutlet weak var accountTableView: UITableView?
    @IBOutlet weak var avatarAccount: UIImageView?
    @IBOutlet weak var containerView: UIView?

    private let informationCell: String = "informationCell"
    private let petPageCell: String = "petPageCell"
    private let logOutCell: String = "logOutCell"
    private let userLeaveCell: String = "userLeaveCell"
    private let deleteAccCell: String = "deleteAccCell"
    private var inforAccount: [String] = ["Tên", "Số điện thoại", "Email"]
    private var petPage: [String] = ["Thú cưng của tôi", "Sổ sức khoẻ thú cưng", "Yêu thích"]
    private var leavePage: [String] = ["Xoá tài khoản", "Đăng xuất"]
    private var userInfo: [String] = []
    private let userManager = UserManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
}

extension AccountViewController {
    private func setupUI() {
        _ = containerView?.applyGradient()
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
                nibName: String(describing: UserLeaveTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: userLeaveCell
        )
//        accountTableView?.register(
//            UINib(
//                nibName: String(describing: DeleteAccountTableViewCell.self),
//                bundle: nil
//            ),
//            forCellReuseIdentifier: deleteAccCell
//        )
//        accountTableView?.register(
//            UINib(
//                nibName: String(describing: LogOutTableViewCell.self),
//                bundle: nil
//            ),
//            forCellReuseIdentifier: logOutCell
//        )
        initHeaderTableView()

        NotificationCenter.default.addObserver(
            self, 
            selector: #selector(didShowTabbar), 
            name: Notification.Name.notiFiTabbarHidden, 
            object: nil
        )
    }
    
    func initHeaderTableView() {
        let headerTableView = StretchyTableHeaderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: 300
            )
        )
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        userImage.image = userManager.getUserInfo().image ?? UIImage(systemName: "person")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        print(" Check \(userManager.getUserInfo().image)")
        //UIImage(named: "person")

        headerTableView.containerView.addSubview(userImage)
        userImage.centerYAnchor.constraint(equalTo: headerTableView.containerView.centerYAnchor).isActive = true

        userImage.centerXAnchor.constraint(equalTo: headerTableView.containerView.centerXAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 190).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 190).isActive = true
        userImage.layer.cornerRadius = 95
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.isUserInteractionEnabled = true
        headerTableView.imageView.image = userManager.getUserInfo().image
        headerTableView.imageView.alpha = 0.5
        headerTableView.imageView.backgroundColor = .primaryColor
        headerTableView.imageView.frame.size.height = 100
        accountTableView?.tableHeaderView = headerTableView
        accountTableView?.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)

        let user: User = userManager.getUserInfo()
        userInfo.append(user.fullName ?? "")
        userInfo.append(user.phoneNumber ?? "")
        userInfo.append(user.email ?? "")

        userImage.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self, 
                action: #selector(didTapViewUserImage)
            )
        )
    }
    
    @objc
    func didShowTabbar() {
        tabBarController?.tabBar.isHidden = false
    }

    @objc
    func didTapViewUserImage() {
        let userImagePreviewView = UserImageView(
            nibName: String(
                describing: UserImageView.self
            ),
            bundle: .main
        )

        userImagePreviewView.didSetUserImage(userManager.getUserInfo().image ?? UIImage())
        userImagePreviewView.modalTransitionStyle = .crossDissolve
        userImagePreviewView.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.tabBar.isHidden = true

        self.present(userImagePreviewView, animated: true)
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
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            let userDetailVc = UserDetailVC(
                nibName: String(
                    describing: UserDetailVC.self
                ),
                bundle: .main
            )
            navigationController?.pushViewController(userDetailVc, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            let myPetsVC = ListPetViewController(
                nibName: String(
                    describing: ListPetViewController.self
                ),
                bundle: .main
            )
            navigationController?.pushViewController(myPetsVC, animated: true)
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
            let favoriteVC = FavoriteVC(
                nibName: String(describing: FavoriteVC.self),
                bundle: .main
            )
            navigationController?.pushViewController(favoriteVC, animated: true)
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            let alert = UIAlertController(title: "Xoá tài khoản", message: "Bạn chắn chắn muốn xoá tài khoản ?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Chắc chắn", style: .default, handler: { action in
                let user = Auth.auth().currentUser
                user?.delete { error in
                  if let error = error {
                    // An error happened.
                  } else {
                      do {
                          try Auth.auth().signOut()
                          let loginVC = LoginViewController(
                              nibName: String(describing: LoginViewController.self),
                              bundle: .main
                          )
                          self.navigationController?.pushViewController(loginVC, animated: true)
                      } catch {
                          print("Sign out error")
                      }
                  }
                }
            })
            let cancel = UIAlertAction(title: "Huỷ", style: .default, handler: { action in
            })
            alert.addAction(ok)
            alert.addAction(cancel)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            print("Log out")
            do {
                try Auth.auth().signOut()
                let loginVC = LoginViewController(
                    nibName: String(describing: LoginViewController.self),
                    bundle: .main
                )
                navigationController?.pushViewController(loginVC, animated: true)
            } catch {
                print("Sign out error")
            }
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
        case 0:
            return userInfo.count
        case 2:
            return 2
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
            inforCell.configUI(inforAccount[indexPath.row], userInfo[indexPath.row])
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
            guard let userLeaveCell = accountTableView?.dequeueReusableCell(
                withIdentifier: userLeaveCell
            ) as? UserLeaveTableViewCell else {
                return UITableViewCell()
            }
            userLeaveCell.titleLabel?.text = leavePage[indexPath.row]
            return userLeaveCell
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
