import SwiftUI
import AVFoundation

struct L1Desafio1: View {
    
    @Binding var state: LessonState
    
    @State private var showingSheet = false
    @State private var isCorrect = false
    @State private var navigateToNextScreen = false
    @State private var LicaoID = [1]
    
    private let voiceSynthesizer =  VoiceSynthesizer() // Criando uma instância da classe VoiceSynthesizer
    
    var body: some View {
        ZStack {
            Color.menu
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.barcolor)
                        .frame(height: 25)
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.progressBar)
                        .frame(width: 72, height: 25)
                }
                .padding(.horizontal)
                
                Text("Dois grupos estão discutindo qual a forma correta de escrever a palavra \"mão\" no plural")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                
                Image("L1Desafio1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 200)
                    .padding()
                    .cornerRadius(200)
                    .foregroundColor(.black)
                
                Text("Declare apoio ao grupo correto")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding()
                
                HStack(spacing: 20) {
                    Button(action: {
                        isCorrect = false
                        showingSheet = true
                    }) {
                        VStack {
                            Image(systemName: "person.3.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 110)
                            Text("Mões")
                                .font(.headline)
                                .padding(.bottom, 10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.botaoOpcao)
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .shadow(radius: 5)
                    }
                    
                    Button(action: {
                        isCorrect = true
                        showingSheet = true
                    }) {
                        VStack {
                            Image(systemName: "person.3.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 110)
                            Text("Mãos")
                                .font(.headline)
                                .padding(.bottom, 10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.botaoOpcao)
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
                
                Button(action: {
                    voiceSynthesizer.speak("Dois grupos estão discutindo qual a forma correta de escrever a palavra mão no plural.")
                    voiceSynthesizer.speak("Declare apoio ao grupo correto.")
                }) {
                    Image(systemName: "speaker.3.fill")
                        .frame(width: 100)
                        .padding()
                        .background(Color.botaoPadrao)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
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
        }
            .onChange(of: navigateToNextScreen) { newValue in
                if newValue {
                    if isCorrect == false {
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
                        state.path.append(2)
                    }
                }
            }
        }
    }
    
    struct CustomPopupView: View {
        var isCorrect: Bool
        @Binding var showing: Bool
        @Binding var navigateToNextScreen: Bool
        private let voiceSynthesizer = VoiceSynthesizer()
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        Text(isCorrect ? "Excelente! Parabéns!" : "Ops... Na próxima dá certo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        voiceSynthesizer.speak(isCorrect ? "Excelente! Parabéns!" : "Ôpis... Na próxima dá certo")
                    }){
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(15)
                .padding()
                
                Button(action: {
                    showing = false
                    navigateToNextScreen = true
                }) {
                    Image(systemName: "forward.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal, 50)
            }
        }
    }
#Preview {
    L1Desafio1(state: .constant(.init()))
}
