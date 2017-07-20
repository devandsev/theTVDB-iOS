//
//  HTTPJSON.swift
//  perfectReads
//
//  Created by Andrey Sevrikov on 20/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

enum HTTPJSON {
    case dictionary(json: [String: Any])
    case array(json: [Any])
}
