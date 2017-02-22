import UIKit

class ValidationAlertViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    class func validateFirst(YourFirst: String) -> Bool
    {
        let REGEX: String
        REGEX = "[a-zA-Z]{5,20}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourFirst)
    }
    
    class  func validateLast(YourLast: String) -> Bool
    {
        let REGEX: String
        REGEX = "[a-zA-Z]{5,20}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourLast)
    }
    
    class  func validatePhone(YourPhone: String) -> Bool
    {
        let REGEX: String
        REGEX = "[0-9]{10}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourPhone)
    }
    class func validateEmail(Your: String) -> Bool
    {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: Your)
    }
    class func doAlert(messageReceived:String, obj:UIViewController)
    {
        let myAlert=UIAlertController(title:"Alert", message:messageReceived,  preferredStyle:UIAlertControllerStyle.alert)
        let okAction=UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:nil)
        myAlert.addAction(okAction)
        obj.present(myAlert, animated : true, completion: nil)
    }
}
