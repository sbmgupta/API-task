import Foundation
import Alamofire

class ApiHandler {
    
    class func fetchData(urlStr:String, parameters:[String:Any], completionHandler: @escaping (Any?) -> ())  {
        
        
        Alamofire.request("http://34.195.206.185/api/"+urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    do{
                        let json : Any! = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        
                        completionHandler(json)
                    }
                    catch {
                        print("error occured")
                    }
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "error")
                break
                
            }
        }
        
    }
  
    
}
