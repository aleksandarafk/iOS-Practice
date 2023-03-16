//
//  ContentView.swift
//  QRCodeScan
//
//  Created by Aleksandar Karamirev on 18/02/2023.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @State private var isPresentingScanner = false
    @State var scannedCode: String = "Scan a QR Code first"
    
    var scannerSheet: some View {
        CodeScannerView(codeTypes: [.qr],
                        completion: { result in
            if case let .success(code) = result {
                self.scannedCode = code.string
                self.isPresentingScanner = false
            }
        })
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(scannedCode)
            Button("Scan a QR code") {
                self.isPresentingScanner = true
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $isPresentingScanner){
                self.scannerSheet
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
