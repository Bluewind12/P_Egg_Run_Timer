//
//  ViewController.swift
//  RunApp
//
//  Created by 百瀬直人 on 2019/09/05.
//  Copyright © 2019 momonyan. All rights reserved.
//

import UIKit
import UserNotifications
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var OKButton: UIButton!
    
    @IBOutlet weak var funStep: UIStepper!
    
    @IBOutlet weak var segseg: UISegmentedControl!
    @IBOutlet weak var funText: UILabel!
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
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue:"se_maoudamashii_onepoint24.mp3"))
        // 通知スタイルを指定
        let request = UNNotificationRequest(identifier: "1234", content: content, trigger: trigger)
        // 通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        let alert: UIAlertController = UIAlertController(title: "確定", message: "大体の目安："+String(segselect/60)+"分", preferredStyle:  UIAlertController.Style.alert)
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func CanselTap(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "設定削除", message: "通知を削除します", preferredStyle:  UIAlertController.Style.alert)
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["1234"])
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Select(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segselect = Int(funStep.value) * 60
        case 1:
            segselect =  Int(funStep.value) *  2 * 60
        case 2:
            segselect =  Int(funStep.value * 2.5) * 60
        case 3:
            segselect = Int(funStep.value *  3.5) * 60
        case 4:
            segselect =  Int(funStep.value) *  5 * 60
        case 5:
            segselect =  Int(funStep.value) *  7 * 60
        case 6:
            segselect =  Int(funStep.value) *  10 * 60
        default:
            segselect = Int(funStep.value) *   5
        }
        print("TEST")
    }
    @IBAction func funTap(_ sender: Any) {
        funText.text = String(Int(funStep.value))+"分"
        switch segseg.selectedSegmentIndex {
        case 0:
            segselect = Int(funStep.value) * 60
        case 1:
            segselect =  Int(funStep.value) *  2 * 60
        case 2:
            segselect =  Int(funStep.value * 2.5) * 60
        case 3:
            segselect = Int(funStep.value *  3.5) * 60
        case 4:
            segselect =  Int(funStep.value) *  5 * 60
        case 5:
            segselect =  Int(funStep.value) *  7 * 60
        case 6:
            segselect =  Int(funStep.value)
        default:
            segselect = Int(funStep.value) *   5
        }
    }
}
