//
//  TrainingDetailVC.swift
//  mock_project
//
//  Created by Le on 09/10/2022.
//

import UIKit

class TrainingDetailVC: UIViewController {

    @IBOutlet weak var trainingDetailTable: UITableView?
    @IBOutlet weak var backButton: UIButton?

    private var training: Training?
    private var trainingCell: String = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func didBackToPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TrainingDetailVC {
    func configUI() {
        _ = view.applyGradient()
        backButton?.setStyleBackButton()
        trainingDetailTable?.delegate = self
        trainingDetailTable?.dataSource = self
        trainingDetailTable?.register(
            UINib(
                nibName: String(describing: TrainingPostCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: trainingCell
        )

        let headerView = StretchyTableHeaderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: 300
            )
        )

        headerView.imageView.image = training?.image
        trainingDetailTable?.tableHeaderView = headerView
        trainingDetailTable?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func didSetTraining(_ training: Training) {
        self.training = training
    }
}

// MARK: - DELEGATE
extension TrainingDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath
    ) -> Bool {
        false
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - DATASOURCE
extension TrainingDetailVC: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = trainingDetailTable?.dequeueReusableCell(
            withIdentifier: trainingCell,
            for: indexPath
        ) as? TrainingPostCell ?? TrainingPostCell()

        cell.didSetData(training ?? Training())
        return cell
    }
}

// MARK: - scroll table
extension TrainingDetailVC {
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        let headerTableView = trainingDetailTable?.tableHeaderView as? StretchyTableHeaderView
        headerTableView?.scrollViewDidScroll(scrollView: scrollView)
    }
}
