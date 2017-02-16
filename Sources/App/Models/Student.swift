import Vapor


final class Student: Model {
    
    var id: Node?
    var exists: Bool = false
    
    var name: String
    var age: String
    
    init(name: String, age: String) {
        self.id = nil
        self.name = name
        self.age = age
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        age = try node.extract("age")
    }
    
    public func makeNode(context: Context) throws -> Node {
        return try Node(node:[
            "id" : id,
            "name" : name,
            "age" : age
            ])
    }
    
    static func prepare(_ database: Database) throws {
        
        try database.create("student") { student in
            student.id()
            student.string("name")
            student.string("age")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("student")
    }
    
}
