import SwiftUI
import AVFoundation

struct L1Desafio3: View {
    
    @Binding var state: LessonState
    
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var showingSheet = false
    @State private var respostacerta = "Qual seria o plural certo de mão"
    @State private var LicaoID = [3]
    private let voiceSynthesizer = VoiceSynthesizer()
    
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Aumento de salários para os trabalhadores"
        case 1:
            return "Proteção do meio ambiente"
        case 2:
            return "Reformas na legislação educacional"
        case 3:
            return "Qual seria o plural certo de mão"
        default:
            return ""
        }
    }
    
    var body: some View {
        ZStack {
            Color.menu.edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.barcolor)
                        .frame(height: 25)
                    
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.progressBar)
                        .frame(width: 216, height: 25)
                }
                .padding(.horizontal)
                
                Text("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um slogan.")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(height: 90)
                    .font(.system(size: 16))
                    .layoutPriority(1)
                
                VStack {
                    Image("L1Desafio3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 200)
                        .padding()
                        .cornerRadius(200)
                        .foregroundColor(.black)
                    
                    Text("Selecione o slogan mais apropriado.")
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    VStack(spacing: 0) {
                        ForEach(0..<4, id: \.self) { index in
                            Button(action: {
                                selectedOption = textForIndex(index)
                                if selectedOption == respostacerta {
                                    isCorrect = true
                                } else {
                                    isCorrect = false
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
                    
                    Button(action: {
                        voiceSynthesizer.speak("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um slogan.")
                        voiceSynthesizer.speak("Selecione o slogan mais apropriado")
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .frame(width: 100)
                            .padding()
                            .background(Color.botaoPadrao)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
            .onChange(of: navigateToNextScreen) { newValue in
                if newValue {
                    if !isCorrect {
                        state.erradas.append(1)
                    }
                    
                    if state.path.count >= 5 {
                        if state.erradas.isEmpty {
                            state.path.removeAll()
                        } else {
                            let first = state.erradas.removeFirst()
                            state.path.append(first)
                        }
                    } else {
                        state.path.append(4)
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                CustomSheetView(isCorrect: isCorrect, onDismiss: {
                    showingSheet = false
                    navigateToNextScreen = true
                })
                .presentationDetents([.fraction(0.25)]) // Ajusta a altura da sheet para 25% da tela
                .background(Color.blue) // Define a cor de fundo da sheet
            }
        }
    }
    
}

#Preview {
    L1Desafio3(state: .constant(.init()))
}
