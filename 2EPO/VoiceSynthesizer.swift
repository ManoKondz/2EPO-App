//
//  VoiceSynthesizer.swift
//  2EPO
//
//  Created by found on 13/09/24.
//

import Foundation
import AVFoundation

class VoiceSynthesizer {
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    // Função para falar o texto
    func speak(_ text: String, rate: Float = 0.5) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR") // Definindo o idioma da fala
        utterance.rate = rate // Definindo a velocidade da fala
        speechSynthesizer.speak(utterance)
    }
}
