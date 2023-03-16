//
//  ContentView.swift
//  Nadqvamsedabachka
//
//  Created by Aleksandar Karamirev on 19/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedLanguage = 0
    let languages = ["en", "ko", "th", "ar"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("hello_world".localizableString(languages[selectedLanguage]))
                    .font(.largeTitle)
                    .padding()
                    .environment(\.layoutDirection, languages[selectedLanguage] == "ar" ? .rightToLeft : .leftToRight)
                Text("second_text".localizableString(languages[selectedLanguage]))
                    .font(.largeTitle)
                    .padding()
                    .environment(\.layoutDirection, languages[selectedLanguage] == "ar" ? .rightToLeft : .leftToRight)
                Picker("", selection: $selectedLanguage) {
                    ForEach(0..<languages.count) { index in
                        Text(languages[index].uppercased())
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                NavigationLink(destination: SecondView(selectedLanguage: languages[selectedLanguage])) {
                    Text("description".localizableString(languages[selectedLanguage]))
                }
            }
        }
    }
}

struct SecondView: View {
    let selectedLanguage: String
    let languages = ["en", "ko", "th", "ar"]
    
    var body: some View{
        VStack{
            Text("third_text".localizableString(selectedLanguage))
                .font(.headline)
                .padding()
        }
    }
}

extension String {
    func localizableString(_ language: String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(selectedLanguage: "")
    }
}
