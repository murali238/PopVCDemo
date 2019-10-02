//
//  ServerSettingsViewController.swift
//  DoubleConnect
//
//  Created by Murali on 08/06/19.
//  Copyright © 2019 MuraliKrishna. All rights reserved.
//

import UIKit

class ServerSettingsViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var textFieldServer: UITextField!
    @IBOutlet weak var textFieldPort: UITextField!
    @IBOutlet weak var viewServer: UIView!
    @IBOutlet weak var viewPort: UIView!
    @IBOutlet weak var serverView: UIView!
    @IBOutlet weak var viewSettingsTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.serverView.addDropShadowToView(targetView: self.serverView)
        
        // Do any additional setup after loading the view.
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "serverAddress") != nil &&  userDefaults.value(forKey: "port") != nil{
            self.textFieldServer.text = userDefaults.value(forKey: "serverAddress") as? String
            self.textFieldPort.text = userDefaults.value(forKey: "port") as? String
        }
        
        self.serverView.layer.cornerRadius = 3.0;
        self.viewServer.layer.borderWidth = 1.0;
        self.viewServer.layer.borderColor = UIColor( red: CGFloat(220/255.0), green: CGFloat(220/255.0), blue: CGFloat(220/255.0), alpha: CGFloat(1.0) ).cgColor
        
        self.viewPort.layer.borderWidth = 1.0;
        self.viewPort.layer.borderColor = UIColor( red: CGFloat(220/255.0), green: CGFloat(220/255.0), blue: CGFloat(220/255.0), alpha: CGFloat(1.0) ).cgColor
        
        self.viewSettingsTop.addshadow(top: false, left: true, bottom: true, right: true)
        self.serverView.addshadow(top: false, left: true, bottom: true, right: true)
        //self.serverView.addDropShadowToView(targetView: self.serverView)
        
        self.title = "Settings"
        
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveServerInfo))
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(buttonCancelClicked))
        self.navigationItem.leftBarButtonItem  = cancelBarButtonItem
    }
    @objc func handleEditBtn(){
        print("clicked")
    }
    func displayAlert(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func buttonCopyRightClicked(_ sender: Any) {
        guard let url = URL(string: "http://artiligent.net") else { return }
        UIApplication.shared.openURL(url)
    }
    
    @IBAction func buttonCancelClicked(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateIpAddress(ipToValidate: String) -> Bool {
        var sin = sockaddr_in()
        var sin6 = sockaddr_in6()
        if ipToValidate.withCString({ cstring in inet_pton(AF_INET6, cstring, &sin6.sin6_addr) }) == 1 {
            // IPv6 peer.
            return true
        }
        else if ipToValidate.withCString({ cstring in inet_pton(AF_INET, cstring, &sin.sin_addr) }) == 1 {
            // IPv4 peer.
            return true
        }
        
        return false;
    }
    
    func isValidPortNumber(stringPort:String)->Bool{
        let portInt:Int = Int(stringPort) ?? 0
        if portInt < 65535 && portInt > 0 {
            return true
        }
        return false
    }
    
    @IBAction func saveServerInfo(_ sender: Any?) {
        self.viewServer.backgroundColor = UIColor.white
        self.viewPort.backgroundColor = UIColor.white
        
        if textFieldServer.text?.count  == 0 || textFieldPort.text?.count == 0 {
            self.displayAlert(title: "Double", message: "Enter valid input")
            return;
        } else if !validateIpAddress(ipToValidate: textFieldServer.text!){
            self.displayAlert(title: "Double", message: "Enter valid ip address")
            return;
        } else if !isValidPortNumber(stringPort:textFieldPort.text!){
            self.displayAlert(title: "Double", message: "Enter valid port")
            return;
        }
        else {
            // self.serverView.isHidden = true
            // self.loginView.isHidden =  false
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.textFieldServer.text, forKey: "serverAddress")
            userDefaults.set(self.textFieldPort.text, forKey: "port")
            userDefaults.synchronize()
            self.dismiss(animated: true, completion: nil)
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.textFieldServer {
            self.viewServer.backgroundColor = UIColor( red: CGFloat(243/255.0), green: CGFloat(242/255.0), blue: CGFloat(244/255.0), alpha: CGFloat(1.0) )
            self.viewPort.backgroundColor = UIColor.white
        } else{
            self.viewServer.backgroundColor = UIColor.white
            self.viewPort.backgroundColor = UIColor( red: CGFloat(243/255.0), green: CGFloat(242/255.0), blue: CGFloat(244/255.0), alpha: CGFloat(1.0) )
        }
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.viewServer.backgroundColor = UIColor.white
        self.viewPort.backgroundColor = UIColor.white
        return true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension UIView {
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 3.0) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.2
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
}
