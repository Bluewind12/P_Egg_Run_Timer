//
//  ViewController.swift
//  RunApp
//
//  Created by 百瀬直人 on 2019/09/05.
//  Copyright © 2019 momonyan. All rights reserved.
//

import UIKit
import  UserNotifications
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var OKButton: UIButton!
    var segselect = 15 * 60
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                
                if granted {
                    print("通知許可")
                    
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self as? UNUserNotificationCenterDelegate
                    
                } else {
                    print("通知拒否")
                }
            })
            
        } else {
            // iOS 9以下
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
    
    @IBAction func OKButtonTap(_ sender: Any) {
        // 設定に必要なクラスをインスタンス化
        let trigger: UNNotificationTrigger
        // 設定したタイミングを起点として1分後に通知したい場合
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(segselect), repeats: false)
        
        // UNMutableNotificationContentクラスをインスタンス化
        let content = UNMutableNotificationContent()
        
        // 通知のメッセージセット
        content.title = ""
        content.body = "卵帰りそう！"
        content.sound = UNNotificationSound.default
        // 通知スタイルを指定
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        
        // 通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    @IBAction func Select(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segselect =  10 * 60
        case 1:
            segselect =  25 * 60
        case 2:
            segselect =  30 * 60
        case 3:
            segselect = 45 * 60
        case 4:
            segselect =  60 * 60
        case 5:
            segselect =  80 * 60
        case 6:
            segselect =  120 * 60
        default:
            segselect =  5
        }
        print("TEST")
    }
}
