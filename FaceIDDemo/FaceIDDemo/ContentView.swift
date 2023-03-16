//
//  ContentView.swift
//  FaceIDDemo
//
//  Created by Aleksandar Karamirev on 18/02/2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    let context = LAContext()
    
    var body: some View {
        Button("Authenticate FaceID") {
            authenticate()
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
    
    func authenticate() {
        let reason = "Please authenticate to access your account."
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
            if success {
                // User authenticated successfully
                DispatchQueue.main.async {
                    // Present the MyView view
                    let myView = SecondView()
                    let rootView = UIHostingController(rootView: myView)
                    UIApplication.shared.windows.first?.rootViewController = rootView
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            } else {
                // Authentication failed
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

}

struct SecondView: View {
    var body: some View {
        Text("faceid demo success")
            .font(.subheadline)
            .padding()
    }
}

struct SecondView_Previews: PreviewProvider{
    static var previews: some View {
        SecondView()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
