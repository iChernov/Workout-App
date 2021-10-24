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
    
    override func prepareForReuse() {
        exerciseIcon.image = nil
    }
    
    func setup(with exercise: ExerciseObject) {
        exerciseNameLabel.text = exercise.name
        setupFavouriteButton(using: exercise)
        // load image from backend or from cache
        DataLoader.loadExerciseImage(imageURLString: exercise.coverImageURL) { [weak self] image in
            if let image = image {
                self?.exerciseIcon.image = image
            }
        }
    }
    
    private func setupFavouriteButton(using exercise: ExerciseObject) {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .medium)
        let starImage = UIImage(systemName: "star", withConfiguration: imageConfiguration)
        favouriteButton.setImage(starImage, for: .normal)
        //
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        // could be moved to a special delegate class, if necessary
    }
}
