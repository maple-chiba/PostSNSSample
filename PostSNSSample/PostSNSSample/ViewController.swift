//
//  ViewController.swift
//  PostSNSSample
//
//  Created by USER on 2015/07/02.
//  Copyright (c) 2015年 YukaChiba. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // ボタン
        var facebook = UIButton(frame: CGRectMake(self.view.frame.width/2-40, 100, 80, 80))
        facebook.setImage(UIImage(named: "button_facebook"), forState: UIControlState.Normal)
        facebook.addTarget(self, action: "onTouchBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        facebook.tag = 0
        self.view.addSubview(facebook)

        var twitter = UIButton(frame: CGRectMake((self.view.frame.width/2)-40, 200, 80, 80))
        twitter.setImage(UIImage(named: "button_twitter"), forState: UIControlState.Normal)
        twitter.addTarget(self, action: "onTouchBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        twitter.tag = 1
        self.view.addSubview(twitter)

        var instagram = UIButton(frame: CGRectMake(self.view.frame.width/2-40, 300, 80, 80))
        instagram.setImage(UIImage(named: "button_insta"), forState: UIControlState.Normal)
        instagram.addTarget(self, action: "onTouchBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        instagram.tag = 2
        self.view.addSubview(instagram)

        var line = UIButton(frame: CGRectMake(self.view.frame.width/2-40, 400, 80, 80))
        line.setImage(UIImage(named: "button_line"), forState: UIControlState.Normal)
        line.addTarget(self, action: "onTouchBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        line.tag = 3
        self.view.addSubview(line)

    }

    func onTouchBtn(sender: UIButton) {

        switch sender.tag {
        case 0:
            // Facebook
            var composeView : SLComposeViewController!
            composeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            // iOS8から？この機能でFacebookへ投稿する際、Facebookアプリがインストールされている場合、文字列をセットすることができなくなりました。無視されちゃいます。アプリがインストールされていないと入れられます。
            composeView.setInitialText("メイプルブログ http://maplesystems.co.jp/blog/")
            composeView.addImage(UIImage(named: "logo"))
            self.presentViewController(composeView, animated: true, completion: nil)
            break
        case 1:
            // Twitter
            var composeView : SLComposeViewController!
            composeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            composeView.setInitialText("メイプルブログ http://maplesystems.co.jp/blog/")
            composeView.addImage(UIImage(named: "logo"))
            self.presentViewController(composeView, animated: true, completion: nil)
            break
        case 2:
            // Instagram
            var postInsta: PostInstagram = PostInstagram()
            if postInsta.canInstagramOpen() {
                postInsta.setImage(UIImage(named: "logo")!)
                self.view.addSubview(postInsta.view)
                self.addChildViewController(postInsta)
            } else {
                // Instagramがインストールされていない
                // アラート
                let alert: UIAlertController = UIAlertController(title: "アラート", message: "Instagramがインストールされてないみたい", preferredStyle: .Alert)
                // OKのアクションを作成する
                let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                    println("Instagramなし OK!")
                }
                alert.addAction(myOkAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            break
        case 3:
            // LINE
            var pastBoard: UIPasteboard = UIPasteboard.generalPasteboard()
            pastBoard.setData(UIImageJPEGRepresentation(UIImage(named: "logo")!, 0.75), forPasteboardType: "public.png")
            var lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name)

            if !(UIApplication.sharedApplication().openURL(NSURL(string: lineUrlString)!)) {
                // LINEが開けない
                let alert: UIAlertController = UIAlertController(title: "アラート", message: "LINEがインストールされてないみたい", preferredStyle: .Alert)
                // OKのアクションを作成する
                let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                    println("LINEなし OK!")
                }
                alert.addAction(myOkAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            break
        default:
            println("そんなボタンない")
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

