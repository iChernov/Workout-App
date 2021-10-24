//
//  ExerciseObject.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21 using https://app.quicktype.io
//

import Foundation

typealias Workout = [ExerciseObject]

struct ExerciseObject: Codable {
    let id: Int
    let name: String
    let coverImageURL: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case coverImageURL = "cover_image_url"
        case videoURL = "video_url"
    }
}
