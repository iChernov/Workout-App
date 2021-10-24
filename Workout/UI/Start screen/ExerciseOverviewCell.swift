//
//  ExerciseOverviewCell.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import UIKit

class ExerciseOverviewCell: UICollectionViewCell {

    @IBOutlet weak var exerciseIcon: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private var exercise: ExerciseObject?
    private let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .medium)
    
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
}
