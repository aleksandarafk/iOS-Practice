//
//  ContentView.swift
//  MessageMe
//
//  Created by Aleksandar Karamirev on 13/02/2023.
//

//importing the needed dependencies (MessageUI)
import SwiftUI
import MessageUI

struct ContentView: View {
    
    //State for showcasing the presented sms composer in the body
    @State private var isPresentingSMSComposer = false
    
    //body view including the button and the sms composer
    var body: some View {
        //button for sending the sms message, using a state to display
        //the message's screen(display)
        Button(action: {
            self.isPresentingSMSComposer = true
        }){
            Text("Send a message with MessageUI")
        }.buttonStyle(.borderedProminent)
        //presenting the view partly
        .sheet(isPresented: $isPresentingSMSComposer) {
            //if statement containing the recepients and the message
            if MFMessageComposeViewController.canSendText() {
                SMSComposer(recipients: ["+359878296019"], message: "If you recieve this message, it means that it was sended with SwiftUI and MessageUI")
                //sending a message in a simulator is impossible, so I am adding an else statement
            } else {
                Text("Cannot send the message(debugging in simulator only, if you recieve this message, check your cellular connection.)")
                    .padding()
            }
        }
    }
}

//struct that converts my storyboard code for siwftui code
//using UIViewControllerRepresentable
struct SMSComposer: UIViewControllerRepresentable {
    
    //variables for the recipients and message passed as strings
    var recipients: [String]
    var message: String
    
    //function to use the SMSComposer in the UI View
    func makeUIViewController(context: UIViewControllerRepresentableContext<SMSComposer>) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        //convert the MFMessageComposeViewController to both
        //message and recipients variables
        controller.body = message
        controller.recipients = recipients
        controller.messageComposeDelegate = context.coordinator
        return controller
    }
    
    //updating the UIViewController
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: UIViewControllerRepresentableContext<SMSComposer>) {
        
    }
    
    //creating a coordinator with current instance
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //coordinator class for the MFMessageComposeViewControllerDelegate(.sheet view)
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        //declaring the struct as a parent variable
        var parent: SMSComposer
            //initializing the SMSComposer for the current instance
        init(_ parent: SMSComposer) {
            self.parent = parent
        }
        
        //animating the sheet view
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }
}

//rendering the sms ui
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
