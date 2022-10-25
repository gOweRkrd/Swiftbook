//
//  WebsiteDescription.swift
//  Networking
//
//  Created by Alexey Efimov on 07.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import Foundation

struct WebsiteDescription: Decodable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
