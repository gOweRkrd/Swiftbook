//
//  AlamofireNetworkRequest.swift
//  Networking
//
//  Created by Alexey Efimov on 19.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        
        request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                var courses = [Course]()
                courses = Course.getArray(from: value)!
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage)->()) {
        
        guard let url = URL(string: url) else { return }
        
        request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseData(url: String) {
        
        request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseString(url: String) {
        
        request(url).responseString { (responseString) in
            
            switch responseString.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func response(url: String) {
        
        request(url).response { (response) in
            
            guard
                let data = response.data,
                let string = String(data: data, encoding: .utf8)
                else { return }
            
            print(string)
        }
    }
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        request(url)
            .validate()
            .downloadProgress { (progress) in
            
            print("totalUnitCount: \(progress.totalUnitCount)\n")
            print("completedUnitCount:\(progress.completedUnitCount)\n")
            print("fractionCompleted:\(progress.fractionCompleted)\n")
            print("loclizedDescription:\(progress.localizedDescription!)\n")
            print("---------------------------------------------------------")
            
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
            
            }.response { (response) in
                
                guard let data = response.data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    completion(image)
                }
        }
    }
    
    static func postRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = ["name": "Network Request",
                                       "link": "https://swiftbook.ru/contents/our-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
                                       "numberOfLessons": 18,
                                       "numberOfTests": 10]
        
        request(url, method: .post, parameters: userData).responseJSON { (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("statusCode ", statusCode)
            
            switch responseJSON.result {
                
            case .success(let value):
                
                print(value)
                
                guard
                    let jsonObject = value as? [String: Any],
                    let course = Course(json: jsonObject)
                    else { return }
                
                var courses = [Course]()
                courses.append(course)
                
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func putRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = ["name": "Network Request with Alamofire",
                                       "link": "https://swiftbook.ru/contents/our-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
                                       "numberOfLessons": 18,
                                       "numberOfTests": 10]
        
        request(url, method: .put, parameters: userData).responseJSON { (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("statusCode ", statusCode)
            
            switch responseJSON.result {
                
            case .success(let value):
                
                print(value)
                
                guard
                    let jsonObject = value as? [String: Any],
                    let course = Course(json: jsonObject)
                    else { return }
                
                var courses = [Course]()
                courses.append(course)
                
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func uploadImage(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let image = UIImage(named: "Notification")!
        let data = image.pngData()!
        
        let httpHeaders = ["Authorization": "Client-ID 1bd22b9ce396a4c"]
        
        upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "image")
            
        }, to: url,
           headers: httpHeaders) { (encodingCompletion) in
            
            switch encodingCompletion {
                
                case .success(request: let uploadRequest,
                              streamingFromDisk: let streamingFromDisk,
                              streamFileURL: let streamFileURL):
                
                print(uploadRequest)
                print(streamingFromDisk)
                print(streamFileURL ?? "strimingFileURL is NIL")
                
                uploadRequest.validate().responseJSON(completionHandler: { (responseJSON) in
                    
                    switch responseJSON.result {
                        
                    case .success(let value):
                        print(value)
                    case .failure(let error):
                        print(error)
                    }
                })
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
