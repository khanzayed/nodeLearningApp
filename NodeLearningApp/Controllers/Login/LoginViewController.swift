//
//  ViewController.swift
//  NodeLearningApp
//
//  Created by Faraz on 27/07/19.
//  Copyright © 2019 Faraz. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import FacebookCore
import FBSDKShareKit

enum LoginType: Int {
    case Google = 1
    case Facebook
    case LinkedIn
    case Email
    case Mobile
}


class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnLinkedin: UIButton!
    @IBOutlet weak var btnSignIn:UIButton!
    
    fileprivate var loginType: LoginType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:" ", style:.plain, target:nil, action:nil)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - set ui
    func setUI() {
        btnSignIn.setTitle("Sign in", for: .normal)
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
        
    }
    
    func applicationDidEnterBackground(notification: NSNotification) {
        
    }
    
    //MARK: - sign in button action
    @IBAction func linkedInLogin(_ sender: UIButton) {
        self.linkedInLogin()
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
        googleLoginfromSignIn()
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        facebookLogin()
    }
    
    @IBAction func emailSignInTapped(_ sender: UIButton) {
        
    }
   
    fileprivate func completedSocialLogin() {
      
    }
    
}

//MARK: Google Login
extension LoginViewController: GIDSignInUIDelegate, GIDSignInDelegate {
    
    func googleLoginfromSignIn() {
        whichSocialLogin(loginName: .Google)
        GIDSignIn.sharedInstance().clientID = Environment.shared.getGoogleClientID()
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let params: [String: Any] = [
                "firstName"         :       user.profile.givenName,
                "lastName"          :       user.profile.familyName,
                "emailID"           :       user.profile.email,
                "socialMediaToken"  :       user.authentication.idToken,
                "loginType"         :       LoginType.Google.rawValue
                //            "userDeviceID"      :   getUserDeviceID()
            ]
            
            socialLoginToServer(params: params) { (sucess) in
                if sucess {
                    GIDSignIn.sharedInstance()?.signOut()
                }
            }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {

    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {

    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - login methods with handler
extension LoginViewController {
    
    func socialLoginToServer(params: [String:Any], completion:  @escaping (Bool) -> Void ) {
//        showHud(self.view)
        UserDetailsAPIHandler().loginWithNode(params, completion: { [weak self] (responseData) in
            guard let strongSelf = self else {
                return
            }
            completion(true)
            if let errorObj =  responseData.errorObject {
//                hideHud(strongSelf.view)

                print(errorObj.message ?? "ERROR")
                return
            }
            
//            if responseData.status == 1040 || responseData.status == 1041 {
//                strongSelf.showSocialLoginErrorPopUp(isEmail: true)
//                return
//            } else if responseData.status == 1042 {
//                strongSelf.showSocialLoginErrorPopUp(isEmail: false)
//                return
//            } else if let response =  responseData.userObj {
//                LoginType = logintType
//                DataAccessor.shared.updateMyProfile(response)
//
//                LoginManagerModel().setUserDefaults(response: response)
//                strongSelf.completedSocialLogin(response: response)
//            }
        })
    }
    
}



extension LoginViewController {
    
    func facebookLogin() {
        whichSocialLogin(loginName: .Facebook)
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                Alert().showAlert(title: "Error logging into fb:", message: "\(error.localizedDescription)", viewController: self, completion: {_ in
                    self.navigationController?.popViewController(animated: true)
                })
            case .cancelled:
                let alert = Alert(vc: self)
                alert.showAlert(title: "Facebook process failed")
            case .success( _, _, let token):
                
                print("facebook token :- \(token.authenticationToken)")
//                self.socialLoginToServer(accessToken: token.authenticationToken, logintType: .Facebook, completion: { (loginSucess) in
//
//                    if loginSucess {
//                        loginManager.logOut()
//                    }
//                })
            }
        }
    }
    
    func linkedInLogin() {
//        whichSocialLogin(loginName: .linkedin)
//        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: {success in
//            showHud(self.view)
//            if LISDKSessionManager.hasValidSession() {
//
//                print("linkedin token :- \(LISDKSessionManager.sharedInstance()!.session.accessToken.accessTokenValue ?? "")")
//                let token = LISDKSessionManager.sharedInstance()!.session.accessToken.accessTokenValue as String
//
//                self.socialLoginToServer(accessToken: token, logintType: .linkedin, completion: { (loginSucess) in
//
//                    if loginSucess {
//                        LISDKSessionManager.clearSession()
//                    }
//                })
//
//            }
//        }) { (error) -> Void in
//            print("Error: \(error!)")
//        }
    }
    
    func whichSocialLogin(loginName: LoginType) {
        loginType = loginName
    }
}
