import Alamofire
import Foundation

enum ServiceParse {
    static func decode<T: Decodable>(_ responseData: DataResponsePublisher<Data>.Output) throws -> T {
        guard let statusCode = responseData.response?.statusCode else {
            throw ServiceErrorDTO(statusCode: 0)
        }
        
        guard let data = responseData.data else {
            throw ServiceErrorDTO(statusCode: statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print("❌ [ServiceParse] Error decodificando JSON: \(error)")
            throw error
        }
    }
}
