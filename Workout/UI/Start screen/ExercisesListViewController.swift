//
//  ViewController.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import UIKit

private let reuseIdentifier = "ExerciseOverviewCell"

class ExercisesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var workout: Workout = Workout()
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var startWorkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(ExerciseOverviewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
    
    func reloadData(with newWorkout: Workout) {
        workout = newWorkout
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return workout.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let exerciseIndex = indexPath.row
        guard exerciseIndex < workout.count else {
            return UICollectionViewCell() // should never be called
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ExerciseOverviewCell {
            cell.setup(with: workout[exerciseIndex])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        }
        
        return CGSize.zero
    }
}
