import SwiftUI

struct Licao3: View {
    @State private var showingPopup = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var showingResult = false
    private let voiceSynthesizer = VoiceSynthesizer() // Criando uma instância da classe
    
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
        NavigationStack {
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
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                        
                        Text("Selecione o slogan mais apropriado.")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    isCorrect = true
                                    showingResult = true
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
                        .background (
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
                    .overlay (
                        CustomPopupView3(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                    )
                    
                    NavigationLink(value: navigateToNextScreen) {
                        EmptyView()
                    }
                    .navigationDestination(isPresented: $navigateToNextScreen) {
                        Licao4()
                    }
                }
            }
        }
    }
    
    struct CustomPopupView3: View {
        var isCorrect: Bool
        @Binding var showing: Bool
        @Binding var navigateToNextScreen: Bool
        private let voiceSynthesizer = VoiceSynthesizer() // Criando uma instância da classe VoiceSynthesizer
        
        
        var body: some View {
            if showing {
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
                        // Botão de tocar som.
                        Button(action: {
                            voiceSynthesizer.speak(isCorrect ? "Excelente! Parabéns!" : "Ôpis... Na próxima dá certo")
                        }) {
                            Image(systemName: "speaker.wave.3.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
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
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showing)
                }
            }
        }
    }
}
    
    #Preview {
        Licao3()
    }
    
