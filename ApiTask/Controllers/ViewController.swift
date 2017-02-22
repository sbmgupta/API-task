
import UIKit
import Alamofire
import ObjectMapper
import Foundation
import CoreData
import SVProgressHUD



class ViewController: UIViewController,UITextFieldDelegate {
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var printMessage=""
    var buttonPress=0
    var username:String?
    var passwordVal:String?
    var name:String?
    var email:String?
    var birthday:String?
    var phone:String?
    var country:String?
    var city:String?
    
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnRemember: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tfUserName.delegate=self
        tfPassword.delegate=self
        self.fetchingCoreData()
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

    @IBAction func btnSignUpAction(_ sender: Any)
    {
        
    }
    
    @IBAction func btnSignInAction(_ sender: Any)
    {
         username=tfUserName.text
         passwordVal=tfPassword.text
        if( (username?.isEmpty)! || (passwordVal?.isEmpty)!  )
        {
            printMessage="All fields are Mandatory"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if !(ValidationAlertViewController.validateEmail(Your: tfUserName.text!))
        {
            printMessage="Invalid Username"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        else if((passwordVal?.characters.count)! < 5)
        {
            printMessage="password should contain at least 5 digits"
            ValidationAlertViewController.doAlert(messageReceived:printMessage, obj:self)
        }
        
        else{
             //            activityIndicator.center = self.view.center
             //            activityIndicator.hidesWhenStopped = true
             //            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
             //            view.addSubview(activityIndicator)
             //            activityIndicator.startAnimating()
             //            UIApplication.shared.beginIgnoringInteractionEvents()
            SVProgressHUD.show()
            SVProgressHUD.setDefaultStyle(.dark)
            //SVProgressHUD.setDefaultAnimationType(.native)
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.fetchData()
            }
 }
    
@IBAction func btnRememberAction(_ sender: Any)
{
        if(buttonPress==0)
        {
            buttonPress=1
            btnRemember.setImage(#imageLiteral(resourceName: "done_white"), for: .normal)
        }
        
        else if(buttonPress==1)
        {
            buttonPress=0
            btnRemember.setImage(#imageLiteral(resourceName: "undone"), for: .normal)
        }
}
    
func fetchData()
{
        let param:[String:Any] = ["email":username ?? "", "password":passwordVal ?? "", "flag":"1"]
        
            ApiHandler.fetchData(urlStr: "login", parameters: param) { (jsonData) in
            //print(jsonData)
            let userModel = Mapper<UserLoginModel>().map(JSONObject: jsonData)
            print(userModel?.msg ?? "")
            print(userModel?.profile?.username ?? "")
            print(userModel?.profile?.phone ?? "")
            print(userModel?.profile?.birthday ?? "")
            self.name=userModel?.profile?.username ?? ""
            self.email=userModel?.profile?.email ?? ""
            self.birthday=userModel?.profile?.birthday ?? ""
            self.city=userModel?.profile?.city ?? ""
            self.phone=userModel?.profile?.phone ?? ""
            self.country=userModel?.profile?.country ?? ""
                //            self.activityIndicator.stopAnimating()
                //            UIApplication.shared.endIgnoringInteractionEvents()
                SVProgressHUD.dismiss()
                UIApplication.shared.endIgnoringInteractionEvents()
            self.performSegue(withIdentifier: "id", sender: self)
    }
}
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?)
{
      if(segue.identifier=="id")
      {
        let DestViewController : ThirdViewController = segue.destination as! ThirdViewController
        DestViewController.name =  self.name ?? ""
        DestViewController.email = self.email ?? ""
        DestViewController.birthday = self.birthday ?? ""
        DestViewController.city = self.city ?? ""
        DestViewController.country = self.country ?? ""
        DestViewController.phone = self.phone ?? ""
      }
        if(buttonPress==1){self.updatingCoreData()}
}
    
func updatingCoreData()
{
      //------------------------------Adding data to CoreData-------------------------//
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let context = appDelegate.persistentContainer.viewContext
     
     let entity =  NSEntityDescription.entity(forEntityName: "User",
     in:context)
     
     let tempData = NSManagedObject(entity: entity!,
     insertInto: context)
    
     tempData.setValue(tfPassword.text ?? "" , forKey: "password")
     tempData.setValue(tfUserName.text ?? "" , forKey: "username")
    
     do{
     try context.save()
     print("\n saved")
     
     
       }
     catch
     {
     //process error
     print("error")
     }
}
  func fetchingCoreData()
  {
        //--------------------------- Fetching from CoreData ------------------------------//
     //1
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let context = appDelegate.persistentContainer.viewContext
     //2
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
     //3
     do {
     let results =
     try context.fetch(fetchRequest)
     print("\n Number of enteries :\(results.count)\n")
     for result in results as! [NSManagedObject]
     {
       if let password = result.value(forKey: "password") as? String
       {
        print("password \(password)")
        tfPassword.text=password
       }
       if let username = result.value(forKey: "username") as? String
       {
        print("username \(username)")
        tfUserName.text=username
       }
     }
        
     } catch let error as NSError {
     print("Could not fetch \(error), \(error.userInfo)")
     }
     
 }
    
}
