//
//  RegisterViewController.swift
//  Nowflix
//
//  Created by APPLE on 2021-04-08.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        //register our user via FirebaseAuth
        
        let alert = UIAlertController(title: "Please, try again", message: "Sign up Error!", preferredStyle: .alert  )
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text
//        else {return}
        else{
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
            return
        }
        
        if(password == confirm){
            
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Error creating firebase user: \(err)")
            } else {
                print("Successfully created user \(String(describing: user))")
            }
        }
        
    }
        
        else{
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
            return
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
