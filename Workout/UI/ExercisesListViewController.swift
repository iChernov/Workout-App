//
//  ViewController.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import UIKit

class ExercisesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataLoader.loadExercisesData { [weak self] workout in
            guard let workout = workout else {
                self?.showSimpleAlert(title: "warning.exerciseLoading.fail.title".localized,
                                      text: "warning.exerciseLoading.fail.text".localized)
                return
            }
            // fill screen with data
        }
    }
}

