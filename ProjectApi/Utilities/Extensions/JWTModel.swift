//
//  JWTModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation
import CryptoKit

extension Data {
    
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}

struct Header: Encodable {
    let alg = "HS256"
    let typ = "JWT"
}

struct Payload: Encodable {
    let uid = "1234567890"
    let identity = "3123123"
}

let secret = "$SECRET$".toBase64()
let privateKey = SymmetricKey(data: Data(secret.utf8))

let headerJSONData = try! JSONEncoder().encode(Header())
let headerBase64String = headerJSONData.urlSafeBase64EncodedString()

let payloadJSONData = try! JSONEncoder().encode(Payload())
let payloadBase64String = payloadJSONData.urlSafeBase64EncodedString()

let toSign = Data((headerBase64String + "." + payloadBase64String).utf8)

let signature = HMAC<SHA256>.authenticationCode(for: toSign, using: privateKey)
let signatureBase64String = Data(signature).urlSafeBase64EncodedString()

let token = [headerBase64String, payloadBase64String, signatureBase64String].joined(separator: ".")
