//
//  PostInstagram.swift
//  Collage
//
//  Created by USER on 2015/06/10.
//  Copyright (c) 2015年 YukaChiba. All rights reserved.
//

import Foundation
import UIKit

class PostInstagram: UIViewController, UIDocumentInteractionControllerDelegate {

    private var interactionController: UIDocumentInteractionController!

    // Instagramを開けるかチェック
    func canInstagramOpen()-> Bool {
        var url: String = "instagram://app"
/*
        if (UIApplication.sharedApplication().openURL(NSURL(string: url)!)) {
            return true
        }
*/
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string: url)!)) {
            return true
        }
        return false
    }

    // Instagramを開く
    func openInstagram() {
        var filePath: String = NSHomeDirectory().stringByAppendingPathComponent("Documents/insta.igo")
        var fileUrl: NSURL = NSURL(fileURLWithPath: filePath)!

        self.interactionController = UIDocumentInteractionController(URL: fileUrl)
        self.interactionController.UTI = "com.instagram.exclusivegram"
        self.interactionController.delegate = self

        var present: Bool = self.interactionController.presentOpenInMenuFromRect(self.view.frame, inView: self.view, animated: true)
        if !present {
            self.closeView()
        }
    }

    // 画像を設定する
    func setImage(image: UIImage) {
        var imageData: NSData = UIImageJPEGRepresentation(image, 0.75)
        var filePath: String = NSHomeDirectory().stringByAppendingPathComponent("Documents/insta.igo")
        imageData.writeToFile(filePath, atomically: true)
    }

    override func viewDidAppear(animated: Bool) {
        self.openInstagram()
    }

    // 終了
    func closeView() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        self.interactionController.delegate = nil
    }

    func documentInteractionController(controller: UIDocumentInteractionController, willBeginSendingToApplication application: String) {

    }

    func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String) {
        self.closeView()
    }

    func documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController) {
        self.closeView()
    }


}
