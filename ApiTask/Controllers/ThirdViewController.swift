
import UIKit

class ThirdViewController: UIViewController
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    var name=""
    var email=""
    var birthday=""
    var phone=""
    var country=""
    var city=""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lblName.text=name
        lblEmail.text=email
        lblBirthday.text=birthday
        lblPhone.text=phone
        lblCountry.text=country
        lblCity.text=city
        // Do any additional setup after loading the view.
    }
  
    @IBAction func btnBackAction(_ sender: Any)
    {
         _ = navigationController?.popViewController(animated: true)
    }
    
}
