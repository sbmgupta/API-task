import Foundation
import ObjectMapper

class UserLoginModel: Mappable {
    var statusCode: Int?
    var msg: String?
    var profile: Profile?
    
    required init?(map: Map){
        statusCode <- map["status_code"]
        msg <- map["msg"]
        profile <- map["profile"]
    }
    
    func mapping(map: Map){
        statusCode <- map["status_code"]
        msg <- map["msg"]
        profile <- map["profile"]
    }
}


class Profile: Mappable {
    var username: String?
    var phone: String?
    var city: String?
    var country: String?
    var email: String?
    var birthday: String?
    
    required init?(map: Map){
        username <- map["username"]
        phone <- map["phone"]
         city <- map["city"]
         country <- map["country"]
        email <- map["email"]
       birthday <- map["birthday"]
        
        
    }
    
    func mapping(map: Map){
        username <- map["username"]
        phone <- map["phone"]
        city <- map["city"]
        country <- map["country"]
        email <- map["email"]
        birthday <- map["birthday"]
        
    }
}
