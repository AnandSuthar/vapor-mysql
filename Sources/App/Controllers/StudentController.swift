import Vapor
import HTTP

final class StudentController {

    
    func addRouteTo(drop: Droplet) {
        
        let student = drop.grouped("student")
        
        student.post    (handler: addStudent)
        student.get     (handler: students)
        student.patch   (handler: patchStudent)
        student.delete  (handler: deleteStudent)
        
    }
    
    
    
    
    
    
    
    func addStudent     (request: Request) throws -> ResponseRepresentable {
        
//        var student = try request.student()
//        try student.save()
        
        
        // OR
        
        
        guard let name = request.data["name"]?.string, let age = request.data["age"]?.string else {
            return try JSON(node:[
                "error": true,
                "message": "user-name or age not found"
                ])
        }
        
        var student = Student(name: name, age: age)
        do {
            try student.save()
            
            return try JSON(node:[
                "error" : false,
                "message" : "Student added successfully"
                ])
            
        } catch let error{
            return try JSON(node:[
                "error" : true,
                "message" : "\(error)"
                ])
        }
        
    }
    
    func students       (request: Request) throws -> ResponseRepresentable {
        
        do {
            // All
            return try JSON(node: Student.all().makeNode())
            // 2. First
            // return try JSON(node: Student.query().first()?.makeNode())
            
            // 3. Conditional
            //return try JSON(node: Student.query().filter("id", "2").all().makeNode())
        } catch {
            
            return try JSON(node:[
                "error" : true,
                "message" : "\(error)"
                ])
        }
        
    }
    
    func patchStudent   (request: Request) throws -> ResponseRepresentable {
        
        guard let studentId = request.data["id"] as? String else {
            return try JSON(node:[
                "error" : true,
                "message" : "student id not found"
                ])
        }
        
        let name = request.data["name"] as? String
        let age = request.data["age"] as? String
        
        
        guard var student = try Student.query().filter("id", studentId).first() else {
            return try JSON(node:[
                "error" : true,
                "message" : "There is no student with id \(studentId))"
                ])
        }
        
        if (name != nil) {
            student.name = name!
        }
        if (age != nil) {
            student.age = age!
        }
        
        do {
            try student.save()
            
            return try JSON(node:[
                "error" : false,
                "message" : "Student with id: \(studentId) updated successfully"
                ])
        } catch {
            return try JSON(node:[
                "error" : true,
                "message" : "\(error)"
                ])
        }
        
    }
    
    func deleteStudent  (request: Request) throws -> ResponseRepresentable {
        
        guard let studentId = request.data["id"] as? String else {
            return try JSON(node:[
                "error" : true,
                "message" : "Student id not found"
                ])
        }
        
        
        guard let student = try Student.query().filter("id", studentId).first() else {
            return try JSON(node:[
                "error" : true,
                "message" : "There is no student with id: \(studentId)"
                ])
        }
        
        do {
            try student.delete()
            
            return try JSON(node:[
                "error" : false,
                "message" : "student with id: \(studentId) deleted successfully"
                ])
        } catch {
            return try JSON(node:[
                "error" : true,
                "message" : "\(error)"
                ])
        }
        
    }
    
}















