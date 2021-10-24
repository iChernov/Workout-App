//
//  ViewController.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import UIKit

private let reuseIdentifier = "ExerciseOverviewCell"

class ExercisesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var workout: Workout = Workout()
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var startWorkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startWorkoutButton.setTitle("exercisesList.startButton.title".localized, for: .normal)

        DataLoader.loadExercisesData { [weak self] workout in
            guard let workout = workout else {
                self?.showSimpleAlert(title: "warning.exerciseLoading.fail.title".localized,
                                      text: "warning.exerciseLoading.fail.text".localized)
                return
            }
            
            // fill collection with data
            self?.reloadData(with: workout)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let workoutExecution = segue.destination as? WorkoutExecutionViewController {
            workoutExecution.workout = self.workout
            workoutExecution.delegate = self
        }
    }
    
    func reloadData(with newWorkout: Workout) {
        workout = newWorkout
        tableView.reloadData()
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? workout.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exerciseIndex = indexPath.row
        guard exerciseIndex < workout.count else {
            return UITableViewCell() // should never be called
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ExerciseOverviewCell {
            cell.setup(with: workout[exerciseIndex])
            return cell
        }
        return UITableViewCell()
    }
}

extension ExercisesListViewController: WorkoutExecutionDelegate {
    func reloadFavourites() {
        tableView.reloadData()
    }
}
