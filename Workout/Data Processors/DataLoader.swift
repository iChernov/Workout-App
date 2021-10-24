//
//  DataLoader.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import Alamofire
import UIKit

class DataLoader {
    fileprivate static let apiLink = "https://jsonblob.com/api/jsonBlob/027787de-c76e-11eb-ae0a-39a1b8479ec2"
    fileprivate static let imageCache = NSCache<NSString, UIImage>()
    
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
            completion(workout)
        }
    }
    
    class func loadExerciseImage(imageURLString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: imageURLString) else {
            completion(nil)
            debugPrint("image URL is not valid")
            return
        }
        
        if let image = self.imageCache.object(forKey: imageURLString as NSString) {
            completion(image)
        } else {
            AF.request(imageURL, method: .get).response { response in
                switch response.result {
                case .success(let responseData):
                    let image = UIImage(data: responseData!, scale: 1)
                    completion(image)
                case .failure(let error):
                    debugPrint("image load failed: \(error)")
                    completion(nil)
                }
            }
        }
    }
}
