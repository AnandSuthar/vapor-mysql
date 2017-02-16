import Vapor
import VaporMySQL

let drop = Droplet()



try drop.addProvider(VaporMySQL.Provider.self)




drop.preparations = [Student.self]




StudentController().addRouteTo(drop: drop)




drop.run()
