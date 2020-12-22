//
//  EncryptionUtility.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-22.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class EncyptionUtility {
    
    class func hashItem(item: String) -> Int {

      var hasher = Hasher()
      item.hash(into: &hasher)
      return hasher.finalize()
    }
    
    class func encodeString(stringToEncode: String) -> Data? {
        return stringToEncode.data(using: String.Encoding.utf8)
    }
    
    class func decodeString(dataToDecode: Data) -> String? {
        return String(data: dataToDecode, encoding: String.Encoding.utf8)
    }
}
