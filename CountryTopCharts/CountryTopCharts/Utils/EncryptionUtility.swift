//
//  EncryptionUtility.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-22.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import CryptoSwift

class EncyptionUtility {
    
//  static  let iv = AES.randomIV(AES.blockSize)
    static let iv: Array<UInt8> = Array("1231231231231234".utf8)
    
    // iv är initial value
    
    static let password: Array<UInt8> = Array("password".utf8)
   static  let salt: Array<UInt8> = Array("salt".utf8)
   
    
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
    

        
        

      
    
    class func encrypt(stringToEncrypt:String) -> Data {
        
        var encryptedData:Data?
        
         do {
             
         let key = try PKCS5.PBKDF2(
             password: password, // password
             salt: salt, // värde som läggs till för att försvåra att en hacker knäcker passwordet
             iterations: 4096, // hur många gånger krypteringen ska köras
             keyLength: 32, /* AES-256, 32 bytes = 256bits */
             variant: .sha512 // vilken hashfunktion, i detta fall sha512
         ).calculate()
             
             let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            // sträng till  bytes till data
             let encryptedBytes = try aes.encrypt(stringToEncrypt.bytes)
              encryptedData = Data(encryptedBytes)
          
         
         } catch {

         }
        return encryptedData!
     }
        
    
    
    class func decrypt(dataToDecrypt:Data) -> String {
        
        var decryptedString: String?
        
        do {
        let key = try PKCS5.PBKDF2(
            password: password,
            salt: salt,
            iterations: 4096,
            keyLength: 32, /* AES-256 */
            variant: .sha512
        ).calculate()
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            
            
            let decryptedBytes = try aes.decrypt(dataToDecrypt.bytes)
            let decryptedData = Data(decryptedBytes)
            decryptedString = String(data: decryptedData, encoding: .utf8 )
        } catch {
            
        }
        
        return decryptedString!
    }
    
}
    
