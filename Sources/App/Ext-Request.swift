import HTTP
import Vapor


extension Request {
    
    func student() throws -> Student {
        guard let json = json else { throw Abort.badRequest}
        return try Student(node: json)
    }
    
}

