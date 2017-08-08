//
//  AppDelegate.swift
//  HiTaxi
//
//  Created by Nong Than on 2/3/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import GooglePlaces
import FBSDKCoreKit
import Google
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let userDefaults = UserDefaults.standard
    var currentTimesOfOpenApp:Int = 0
    var window: UIWindow?

 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let notificationType:UIUserNotificationType = [.alert, .sound, .badge]
        let notificationsSetting = UIUserNotificationSettings(types: notificationType, categories: nil)
        application.registerUserNotificationSettings(notificationsSetting)
        application.registerForRemoteNotifications()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let layout = UICollectionViewLayout()
        window?.rootViewController = UINavigationController(rootViewController: TrangChu(collectionViewLayout: layout))
        
        //đổ mầu cho navigationbar
        // UINavigationBar.appearance().barTintColor = UIColor.blue
        
        //Khi chạy lên thanh status chữ xẽ mầu trắng
        application.statusBarStyle = .lightContent
        
        
        let backgroundStatusBar:UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "bgBar")
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            return img
        }()
        
  
        
        // bỏ đường kẻ bên gưới mavigation bar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(backgroundStatusBar.image , for: .default )
       ///
        var err:NSError?
        GGLContext.sharedInstance().configureWithError(&err)
        
        if err != nil {
            print("LOIGOOGLE",err!)
        }
        
        GIDSignIn.sharedInstance().signInSilently()
        // cai dat key google
        GMSPlacesClient.provideAPIKey("AIzaSyCWa0b0qghBA0r_LhHHtzGMNZIaYUYCSLM")
        //
      
        
        return FBSDKApplicationDelegate.sharedInstance().application(application,  didFinishLaunchingWithOptions: launchOptions)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) || GIDSignIn.sharedInstance().handle(url, sourceApplication:sourceApplication, annotation:annotation)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
       
        for items in userInfo {
            if "\(items.key)" == "aps" {
                let v = items.value as! [String:Any]
                for (key, vl) in v {
                    if key == "alert" {
                        let m = ModelThongBao()
                        m.ngoiDungThongBao = vl as? String
                        m.ngayThongBao = Date()
                        SQLiteConfig().ThemThongBao(tb: m)
                    }
                }
            }
        }
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let dataToken = "\(deviceToken as NSData)".replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "").uppercased()
        print("dataToken: \(deviceToken as NSData)")
        ModelNguoiDung.AddToken(token: dataToken) { (st) in
            
        }
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TrangChu.reloadView), userInfo: nil, repeats: true)
      
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     
    }


}

