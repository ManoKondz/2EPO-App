import SwiftUI

struct Licao5: View {
    @State private var showingPopup = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var showingResult = false
    private let voiceSynthesizer = VoiceSynthesizer() // Criando uma instância da classe VoiceSynthesizer

    
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Com Mões, Tudo Fica Melhor"
        case 1:
            return "Com Mãos, O Mundo Se Conecta"
        case 2:
            return "Com Moisés, Tudo Fica Melhor"
        case 3:
            return "Com Mãoses, O Mundo Se Conecta"
        default:
            return ""
        }
    }
    
    var body: some View {
        NavigationStack {
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
                            .frame(width: 360, height: 25) // A largura é ajustada com base no progresso
                    }
                    .padding(.horizontal)
                    
                    Text("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um `slogan`.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 90)
                        .font(.system(size: 16))
                        .layoutPriority(1)
                    
                    VStack{
                        // Retângulo branco
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                        
                        
                        Text("Selecione o `slogan` mais apropriado.")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        // Caixa verde das respostas
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    isCorrect = true
                                    showingResult = true
                                    selectedOption = textForIndex(index)
                                }) {
                                    Text(textForIndex(index))
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
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
                            voiceSynthesizer.speak("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um `slogan`.")
                            voiceSynthesizer.speak("Selecione o `slogan` mais apropriado.")
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
                    .overlay(
                        CustomPopupView(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                    )
                    
                    NavigationLink(value: navigateToNextScreen) {
                        EmptyView()
                    }
                    .navigationDestination(isPresented: $navigateToNextScreen) {
                        Licao5()
                    }
                    
                }
            }
        }
    }
}
struct CustomPopupView4: View {
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
#Preview {
    Licao5()
}
