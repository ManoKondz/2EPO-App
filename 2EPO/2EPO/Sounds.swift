////
////  Sounds.swift
////  2EPO
////
////  Created by found on 10/09/24.
////
//
//import SwiftUI
//import AVKit
//
//class Soundsmanager{
//    static let instance = Soundsmanager()
//    
//    var player: AVAudioPlayer?
//    
//    func Playsound() {
//        guard let url = URL( ) else {return }
//        
//        do{
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.play()
//        }catch let erro{
//            print("Erro ao tocar esse audio. \(erro.localizedDescription)")
//        }
//    }
//}
//
//
//
//
//struct Sounds: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    Sounds()
//}
