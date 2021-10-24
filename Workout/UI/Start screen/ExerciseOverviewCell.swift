//
//  ExerciseOverviewCell.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import UIKit

class ExerciseOverviewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with exercise: ExerciseObject) {
        contentView.backgroundColor = .red
    }
}
