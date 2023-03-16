//
//  ViewController.swift
//  MessageApp
//
//  Created by Aleksandar Karamirev on 12/02/2023.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //linking the button from the storyboard
    @IBAction func smsButton(_ sender: UIButton) {
        //adding an if statement that check whether I can send the message.
        //if i can send the message, i use a body and a recipient variables
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "This message was sent with MessageUI"
            controller.recipients = ["insert a number"]
            //an interface that responds to the user interaction with the message composer
            controller.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate
            self.present(controller, animated: true, completion: nil)
        }
        //sending a message in a simulator is impossible, so I am adding an else statement
        else{
            print("Cannot send the message")
        }
        
        func messageComposeViewController(controller:
                                          MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
            //displaying the message screen with animation.
            self.dismiss(animated: true, completion: nil)
        }
    }
}
