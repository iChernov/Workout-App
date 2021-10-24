//
//  WorkoutExecutionViewController.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import UIKit

private let reuseIdentifier = "WorkoutExecutionCell"

protocol WorkoutExecutionDelegate: AnyObject {
    func reloadFavourites()
}

class WorkoutExecutionViewController: UIViewController {
    var workout: Workout = Workout()
    var currentExercise = 0
    var executionTimer: Timer?
    weak var delegate: WorkoutExecutionDelegate?
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var exerciseIcon: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    private var exercise: ExerciseObject?
    private let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextStepButton.setTitle("workoutExecution.doneButton.title".localized, for: .normal)
        executionTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(goToNextExercise), userInfo: nil, repeats: true)
        
        setup(with: workout[currentExercise])
    }
    
    func setup(with exercise: ExerciseObject) {
        self.exercise = exercise
        exerciseNameLabel.text = exercise.name
        setupFavouriteButton(using: exercise)
        DataLoader.loadExerciseImage(imageURLString: exercise.coverImageURL) { [weak self] image in
            if let image = image {
                self?.exerciseIcon.image = image
            }
        }
    }
    
    private func setupFavouriteButton(using exercise: ExerciseObject) {
        var starImage = UIImage(systemName: "star", withConfiguration: imageConfiguration)
        if DataLoader.isExerciseFavourite(exerciseName: exercise.name) == true {
            starImage = UIImage(systemName: "star.fill", withConfiguration: imageConfiguration)
        }
        favouriteButton.setImage(starImage, for: .normal)
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        guard let exercise = exercise else { return }
        var starImage: UIImage?

        if DataLoader.isExerciseFavourite(exerciseName: exercise.name) == true {
            starImage = UIImage(systemName: "star", withConfiguration: imageConfiguration)
            DataLoader.changeFavourite(of: exercise.name, to: false)
        } else {
            starImage = UIImage(systemName: "star.fill", withConfiguration: imageConfiguration)
            DataLoader.changeFavourite(of: exercise.name, to: true)
        }
        favouriteButton.setImage(starImage, for: .normal)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        delegate?.reloadFavourites()
    }
    
    @IBAction func nextStepAction(_ sender: Any) {
        goToNextExercise()
        executionTimer?.invalidate()
        executionTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(goToNextExercise), userInfo: nil, repeats: true)
    }
    
    @objc func goToNextExercise() {
        currentExercise += 1
        if currentExercise >= workout.count {
            executionTimer?.invalidate()
            self.dismiss(animated: true, completion: nil)
        } else {
            setup(with: workout[currentExercise])
        }
    }
}
