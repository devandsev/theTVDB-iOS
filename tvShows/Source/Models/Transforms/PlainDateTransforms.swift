//
//  PlainDateTransforms.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 16/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class PlainDateTransform: CustomDateFormatTransform {
    
    init() {
        super.init(formatString: "yyyy-MM-dd HH:mm:ss")
    }
}
