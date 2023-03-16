//
//  ContentView.swift
//  AirDropDemo
//
//  Created by Aleksandar Karamirev on 18/02/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var fileURL: URL?
    @State private var documentPickerDelegate: DocumentPickerDelegate? // add delegate property
    
    var body: some View {
        VStack {
            if let fileURL = fileURL {
                Text("File selected: \(fileURL.lastPathComponent)")
            } else {
                Text("No file selected")
            }
            Button("Select file") {
                let picker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
                documentPickerDelegate = DocumentPickerDelegate(fileSelectedHandler: { fileURL in
                    self.fileURL = fileURL
                })
                picker.delegate = documentPickerDelegate
                UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true, completion: nil)
            }
            
            Button("Send file") {
                guard let fileURL = fileURL else {
                    return
                }
                
                let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
            }
        }
        
    }
}

class DocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    let fileSelectedHandler: (URL) -> Void
    
    init(fileSelectedHandler: @escaping (URL) -> Void) {
        self.fileSelectedHandler = fileSelectedHandler
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            fileSelectedHandler(url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
