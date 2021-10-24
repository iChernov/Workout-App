//
//  DataLoader.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import Alamofire

class DataLoader {
    fileprivate static let apiLink = "https://jsonblob.com/api/jsonBlob/027787de-c76e-11eb-ae0a-39a1b8479ec2"
    
    class func loadExercisesData(completion: @escaping (Workout?) -> Void) {
        AF.request(apiLink).validate().responseDecodable(of: Workout.self) { response in
            guard let workout = response.value else {
                switch response.result {
                case .failure(let error):
                    debugPrint("Something went wrong while loading exercise list from server: \(error)")
                    completion(nil)
                default:
                    
                    completion(nil)
                }
                debugPrint(response.result)
                return
            }
            for exercise in workout {
                print(exercise.name)
            }
            completion(workout)
        }
    }
}
