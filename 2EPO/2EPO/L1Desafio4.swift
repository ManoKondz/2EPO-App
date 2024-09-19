import SwiftUI
import AVFoundation

struct L1Desafio4: View {
    @Binding var state: LessonState
    
    @State private var showingPopup = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var showingSheet = false
    @State private var respostacerta = "Para seguir a norma culta padrão do português."
    private let voiceSynthesizer = VoiceSynthesizer()
    
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Para seguir a norma culta padrão do português"
        case 1:
            return "É importante para o equilíbrio do mundo"
        case 2:
            return "Agradar uma parcela da sociedade"
        case 3:
            return "Você ganha superpoderes linguísticos "
        default:
            return ""
        }
    }
    
    var body: some View {
        //NavigationStack {
        ZStack {
            Color.menu // Cor de fundo aplicada a toda a tela
                .edgesIgnoringSafeArea(.all) // Garante que a cor preencha toda a tela
            
            VStack {
                HStack {
                    Spacer()
                }
                .padding()
                
                // Barra de progresso
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.barcolor)
                        .frame(width: 360,height: 25) // Define altura da barra de fundo
                    
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.progressBar)
                        .frame(width: 288, height: 25) // A largura é ajustada com base no progresso
                }
                .padding(.horizontal)
                
                Text("Auxilie os participantes da manifestação a elucidar as concepções da criança.")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(height: 90)
                    .font(.system(size: 16))
                    .layoutPriority(1)
                
                VStack{
                    // Retângulo branco
                    Image("L1Desafio4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 200)
                        .padding()
                        .cornerRadius(200)
                        .foregroundColor(.black)
                    
                    
                    Text("Escolha a alternativa correta!")
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    // Caixa verde das respostas
                    VStack(spacing: 0) {
                        ForEach(0..<4, id: \.self) { index in
                            Button(action: {
                                // Logica para saber se a resposta escolhida é a certa
                                if selectedOption != respostacerta{
                                    isCorrect = false
                                } else{
                                    isCorrect = true
                                }
                                showingSheet = true
                            }) {
                                Text(textForIndex(index))
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                    .frame(height: 10)
                                    .padding()
                                    .background(Color.botaoOpcao)
                                    .cornerRadius(10)
                            }
                            
                            if index < 3 {
                                Divider()
                                    .background(Color("botões"))
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 2)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.botaoOpcao)
                            )
                    )
                    .padding(.bottom, 20)
                    
                    // Botão de som
                    Button(action: {
                        // Ação do botão de som
                        voiceSynthesizer.speak("Auxilie os participantes da manifestação a elucidar as concepções da criança.")
                        voiceSynthesizer.speak("Escolha a alternativa correta!")
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .frame(width: 120, height: 50)
                            .padding()
                            .background(Color.botaoPadrao)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .sheet(isPresented: $showingSheet) {
                    CustomSheetView(isCorrect: isCorrect, onDismiss: {
                        showingSheet = false
                        navigateToNextScreen = true
                    })
                    .presentationDetents([.fraction(0.25)]) // Ajusta a altura da sheet para 25% da tela
                    .background(Color.blue) // Define a cor de fundo da sheet
                }
                    .onChange(of: navigateToNextScreen) { newValue in
                        if newValue {
                            if isCorrect == false {
                                state.erradas.append(1)
                            }
                            
                            // VOLTAR PARA QUESTOES ERRADAS
                            if state.path.count >= 5 {
                                
                                if state.erradas.isEmpty {
                                    state.path.removeAll()
                                } else {
                                    // PEGA A PRIMEIRA LIÇÃO ERRADA E REMOVE DAS ERRADAS
                                    let first = state.erradas.removeFirst()
                                    state.path.append(first)
                                }
                            } else {
                                // VAI PARA PROXIMA LICAO
                                state.path.append(2)
                            }
                        }
                    }
                }
            }
            //}
        }
    }
    #Preview {
        L1Desafio4(state: .constant(.init()))
    }
