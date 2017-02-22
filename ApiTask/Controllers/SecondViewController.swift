
import UIKit
import SkyFloatingLabelTextField
import Alamofire
import ObjectMapper

class SecondViewController: UIViewController,UITextFieldDelegate {

   var printMessage=""
    
    @IBOutlet weak var tfName: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var tfPassword: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var tfPhone: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var tfCountry: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var tfCity: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var tfAddress: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var btnNext: UIButton!
    
    
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tfName.delegate=self
        tfEmail.delegate=self
        tfPassword.delegate=self
        tfPhone.delegate=self
        tfCountry.delegate=self
        tfCity.delegate=self
        tfAddress.delegate=self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
  
    @IBAction func btnBackAction(_ sender: Any) {
        
         _ = navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func btnNextAction(_ sender: Any) {
        
        
        let name=tfName.text
        let passwordVal=tfPassword.text
        let email=tfEmail.text
        let phone=tfPhone.text
        let country=tfCountry.text
        let city=tfCity.text
        let address=tfAddress.text
        
        if( (name?.isEmpty)! || (passwordVal?.isEmpty)! || (email?.isEmpty)! || (phone?.isEmpty)! || (country?.isEmpty)! || (city?.isEmpty)! || (address?.isEmpty)!)
        {
            printMessage="All fields are Mandatory"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if !(ValidationAlertViewController.validateFirst(YourFirst: tfName.text!))
        {
            printMessage="Invalid Name"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if !(ValidationAlertViewController.validateEmail(Your: tfEmail.text!))
        {
            printMessage="Invalid Email"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if((passwordVal?.characters.count)! < 8)
        {
            printMessage="password should contain at least 8 digits"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if !(ValidationAlertViewController.validatePhone(YourPhone: tfPhone.text!))
        {
            printMessage="Invalid Phone"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if !(ValidationAlertViewController.validateFirst(YourFirst: tfCountry.text!))
        {
            printMessage="Invalid Country Name"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if !(ValidationAlertViewController.validateFirst(YourFirst: tfCity.text!))
        {
            printMessage="Invalid City Name"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else
        {let param : [String : Any] = ["username": tfName.text ?? "",
                                       "email" : tfEmail.text ?? "",
                                       "password" : tfPassword.text ?? "",
                                       "phone" : tfPhone.text ?? "",
                                       "country" : tfCountry.text ?? "",
                                       "city" : tfCity.text ?? "",
                                       "address" : tfAddress.text ?? "",
                                       "flag" : 1,
                                       "birthday" : "01/01/1996",
//                                       "country_code" : "91",
//                                       "postal_code" : "134109",
//                                       "country_iso3" : "INDIA",
                                       "state" : "CHD"]
            ApiHandler.fetchData(urlStr: "signup", parameters: param) { (jsonData) in
                let userModel = Mapper<UserLoginModel>().map(JSONObject : jsonData)
                self.printMessage="Success"
                ValidationAlertViewController.doAlert(messageReceived:self.printMessage, obj:self)
        }

    }


  }
}
