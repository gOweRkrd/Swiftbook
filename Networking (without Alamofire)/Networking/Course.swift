//
//  Course.swift
//  Networking
//
//  Created by Alexey Efimov on 07.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import Foundation

struct Course: Decodable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
