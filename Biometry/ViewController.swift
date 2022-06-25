//
//  ViewController.swift
//  Biometry
//
//  Created by Youngchai Song on 05/06/2018.
//  Copyright © 2018 Youngchai Song. All rights reserved.
//

import UIKit


import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad(
        
            
        )
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        let alert = UIAlertController(title:"", message: "생체 인증을 사용하여 서비스를 이용할 수 있습니다.", preferredStyle: UIAlertControllerStyle.alert)
        //let vc = PinViewController()
        /*
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
        action in
        
        }))
        */
        let action1 = UIAlertAction(title: "취소", style: UIAlertActionStyle.default, handler: {action in
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "PinViewController") as! UIViewController
                        self.present(vc, animated: false, completion: nil)
            
        })
        
        let action2 = UIAlertAction(title: "설정", style: UIAlertActionStyle.default, handler: {action in
            
            
        })
        
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: false, completion: nil)
 

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func biometryButton(_ sender: Any) {
        
        let authContext = LAContext()
        
        var error: NSError?
        
        var description: String!
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            if #available(iOS 11.0, *){
            switch authContext.biometryType {
            case .faceID:
                description = "계정 정보를 열람하기 위해서 Face ID로 인증 합니다."
                break
            case .touchID:
                description = "계정 정보를 열람하기 위해서 Touch ID로 인증 사용합니다."
                break
            case .none:
                description = "계정 정보를 열람하기 위해서는 로그인하십시오."
                break
            }}
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description) { (success, error) in
                
                if success {
                    print("인증 성공")
                    
                } else {
                    print("인증 실패")
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }  else {
            // Touch ID・Face ID를 사용할 수없는 경우
            let errorDescription = error?.userInfo["NSLocalizedDescription"] ?? ""
            print(errorDescription)
            description = "생체인식이 등록되어 있지 않습니다."
            
            let alertController = UIAlertController(title: "Authentication Required", message: description, preferredStyle: .alert)
            /*
            weak var usernameTextField: UITextField!
            alertController.addTextField(configurationHandler: { textField in
                //textField.placeholder = "User ID"
                usernameTextField = textField
            })
            weak var passwordTextField: UITextField!
            alertController.addTextField(configurationHandler: { textField in
                //textField.placeholder = "Password"
                //textField.isSecureTextEntry = true
                passwordTextField = textField
            })
            */
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
            
            }))
            alertController.addAction(UIAlertAction(title: "Log In", style: .destructive, handler: { action in
                // 를
                //print(usernameTextField.text! + "\n" + passwordTextField.text!)
                //UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                //UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                if #available(iOS 10.0, *) {
                        let url = NSURL(string:"App-prefs:root=TOUCHID_PASSCODE")! as URL
                        UIApplication.shared.open(url)
                    }

                //prefs:root=PASSCODE
                //TOUCHID_PASSCODE"
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=TOUCHID_PASSCODE"]];

                //NSURL URL
                //if ([[UIApplication.shared.canOpenURL(NSURL(string: UIApplicationOpenSettingsURLString)! as "prefs:root=WIFI")]])
                
                /*
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
                } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=WIFI"]];
                }*/
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
}

