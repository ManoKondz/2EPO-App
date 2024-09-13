// Comentários Powered by XachátGPT

import SwiftUI
import AVFoundation


// Definição da view "Licao1", que representa a primeira lição.
struct Licao1: View {
    // Estados que controlam a exibição do popup, o feedback da resposta e a navegação para a próxima tela.
    @State private var showingResult = false
    @State private var isCorrect = false
    @State private var navigateToNextScreen = false
    
    private let voiceSynthesizer = VoiceSynthesizer() // Criando uma instância da classe VoiceSynthesizer
    
    var body: some View {
        // Cria uma pilha de navegação para controlar a transição entre telas.
        NavigationStack {
            ZStack {
                // Definição de cor de fundo para toda a tela.
                Color.menu
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Barra de progresso no topo, com estilo arredondado.
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(height: 25)
                        
                        // Parte preenchida da barra de progresso, indicando 72 unidades de avanço.
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 72, height: 25)
                    }
                    .padding(.horizontal)
                    
                    // Texto que descreve o contexto da lição.
                    Text("Dois grupos estão discutindo qual a forma correta de escrever a palavra \"mão\" no plural")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    
                    // Exibe uma imagem relacionada ao desafio.
                    Image("desafio1")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .foregroundColor(.black)
//                        .frame(width: 250, height: 200)

                        .padding()
                    
                    // Instrução para o usuário interagir com o exercício.
                    Text("Declare apoio ao grupo correto")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .padding()
                    
                    // Botões de múltipla escolha: "Mões" e "Mãos".
                    HStack(spacing: 20) {
                        // Botão que o usuário pode selecionar. No caso de seleção incorreta ("Mões").
                        Button(action: {
                            isCorrect = false // Define a resposta como incorreta.
                            showingResult = true // Exibe o popup de resultado.
                        }) {
                            VStack {
                                Image(systemName: "person.3.fill") // Ícone gráfico
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 110)
                                Text("Mões") // Texto da opção.
                                    .font(.headline)
                                    .padding(.bottom, 10)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.botaoOpcao) // Cor de fundo do botão.
                            .cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        }
                        
                        // Botão que o usuário pode selecionar. No caso de seleção correta ("Mãos").
                        Button(action: {
                            isCorrect = true // Define a resposta como correta.
                            showingResult = true // Exibe o popup de resultado.
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
                    
                    // Botão de som para ativar a leitura em voz alta (função a ser implementada).
                    Button(action: {
                        voiceSynthesizer.speak("Dois grupos estão discutindo qual a forma correta de escrever a palavra mão no plural.")
                        voiceSynthesizer.speak("Declare apoio ao grupo correto.")
                    }) {
                        Image(systemName: "speaker.3.fill") // Ícone de som.
                            .frame(width: 100)
                            .padding()
                            .background(Color.botaoPadrao)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                }
                .padding()
                
                // Exibe o popup de feedback ao usuário quando a resposta é dada.
                .overlay(
                    CustomPopupView(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                )
                
                // Link de navegação que leva à próxima lição (Licao2).
                NavigationLink(value: navigateToNextScreen) {
                    EmptyView()
                }
                .navigationDestination(isPresented: $navigateToNextScreen) {
                    Licao2() // A próxima tela que será exibida.
                }
            }
        }
    }
}

// Popup customizado que exibe o feedback ao usuário após responder a questão.
struct CustomPopupView: View {
    var isCorrect: Bool // Indica se a resposta do usuário está correta.
    @Binding var showing: Bool // Controla a exibição do popup.
    @Binding var navigateToNextScreen: Bool // Controla a navegação para a próxima tela.
    private let voiceSynthesizer = VoiceSynthesizer()
    // Criando uma instância da classe VoiceSynthesizer
    var body: some View {
        if showing {
            VStack {
                HStack {
                    // Ícone que indica se a resposta está certa ou errada.
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    
                    // Mensagem de feedback com base na resposta do usuário.
                    VStack(alignment: .leading) {
                        Text(isCorrect ? "Excelente! Parabéns!" : "Ops... Na próxima dá certo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    // Ícone de som (potencial para leitura em voz alta do feedback).
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
                    
                    // Botão para avançar para a próxima tela.
                    Button(action: {
                        showing = false // Oculta o popup.
                        navigateToNextScreen = true // Navega para a próxima tela.
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
                .transition(.move(edge: .bottom)) // Animação de transição para o popup.
                .animation(.easeInOut, value: showing) // Animação de aparecimento/desaparecimento do popup.
            }
        }
    }
}
#Preview {
    Licao1()
}
