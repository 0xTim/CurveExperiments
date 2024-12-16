import Crypto
import Foundation
import Curve25519

//public struct CurveKeys {
//    public func generateCryptoKey() throws -> Crypto.Curve25519.Signing.PrivateKey {
//        let privateKey = Crypto.Curve25519.Signing.PrivateKey()
//        return privateKey
//    }
//
//    public func loadCurveKey(from data: Data) throws -> Curve25519{
//
//}

@main
struct Curve25519Experiments {
    static func main() throws {
        let key = Crypto.Curve25519.Signing.PrivateKey()
        let data = Data([UInt8].random(count: 32))
        let cryptoSignature = try key.signature(for: data)
        let curveSignature = try Curve25519.signature(for: data, privateKey: key.rawRepresentation, randomData: Data([UInt8].random(count: 64)))

        guard key.publicKey.isValidSignature(cryptoSignature, for: data) else {
            fatalError("Crypto signature verification failed")
        }

        guard key.publicKey.isValidSignature(curveSignature, for: data) else {
            fatalError("Curve signature verification failed")
        }

        guard Curve25519.verify(signature: curveSignature, for: data, publicKey: key.publicKey.rawRepresentation) else {
            fatalError("Curve signature verification failed")
        }

        guard Curve25519.verify(signature: cryptoSignature, for: data, publicKey: key.publicKey.rawRepresentation) else {
            fatalError("Crypto signature verification failed")
        }
    }

}

extension Array where Element: FixedWidthInteger {
    public static func random(count: Int) -> [Element] {
        var array: [Element] = .init(repeating: 0, count: count)
        (0..<count).forEach { array[$0] = Element.random(in: .min ... .max) }
        return array
    }
}
