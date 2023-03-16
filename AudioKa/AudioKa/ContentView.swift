//
//  ContentView.swift
//  AudioKa
//
//  Created by Aleksandar Karamirev on 09/02/2023.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        
        Home()
            // always dark mode...
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var record = false
    // creating instance for recroding...
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    // Fetch Audios...
    @State var audios : [URL] = []
    @State var player: AVAudioPlayer?
    var body: some View{
        NavigationView{
            VStack{
                List(self.audios, id:\.self){ i in
                    HStack {
                        Text(i.relativeString)
                        Spacer()
                        Button(action: {
                            do {
                                self.player = try AVAudioPlayer(contentsOf: i)
                                self.player?.play()
                            } catch {
                                print("Failed to play audio: \(error.localizedDescription)")
                            }
                            
                        }){
                            Image(systemName: "play.circle")
                        }
                    }
                }
                Button(action: {
                    do{
                        if self.record{
                            self.recorder.stop()
                            self.record.toggle()
                            self.getAudios()
                            return
                        }
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        // same file name...
                        // so were updating based on audio count...
                        let filName = url.appendingPathComponent("audio\(self.audios.count + 1).m4a")
                        
                        let settings = [
                            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey : 12000,
                            AVNumberOfChannelsKey : 1,
                            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
                                                ]

                        self.recorder = try AVAudioRecorder(url: filName, settings: settings)
                        self.recorder.record()
                        self.record.toggle()
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }) {
                    ZStack{
                        Circle()
                            .fill(Color.red)
                            .frame(width: 75, height: 75)
                        if self.record{
                            Circle()
                                .stroke(Color.white, lineWidth: 6)
                                .frame(width: 85, height: 85)
                        }
                    }
                }
                .padding(.vertical, 25)
            }
            .navigationBarTitle("Record Audio")
        }
        .alert(isPresented: self.$alert, content: {
            
            Alert(title: Text("Error"), message: Text("Enable Acess"))
        })
        .onAppear {
            do{
                // Intializing...
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord)
                
                // requesting permission
                // for this we require microphone usage description in info.plist...
                self.session.requestRecordPermission { (status) in
                    if !status{
                        // error msg...
                        self.alert.toggle()
                    }
                    else{
                        // if permission granted means fetching all data...
                        self.getAudios()
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getAudios(){
        
        do{
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            // fetch all data from document directory...
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            // updated means remove all old data..
            
            self.audios.removeAll()
            
            for i in result{
                
                self.audios.append(i)
            }
        }
        catch{
            
            print(error.localizedDescription)
        }
    }
}
