import SwiftUI

// Definição da tela principal para o desafio 3
struct L2Desafio3: View {
    // Propriedades de estado que controlam a lógica e o estado da interface
    @State private var showingPopup = false // Controla a visibilidade do popup de resultado
    @State private var selectedOption = "" // Armazena a opção selecionada pelo usuário
    @State private var navigateToNextScreen = false // Controla a navegação para a próxima tela
    @State private var isCorrect = false // Indica se a resposta está correta
    @State private var showingResult = false // Controla a exibição do resultado
    private let voiceSynthesizer = VoiceSynthesizer() // Instância para sintetização de voz (para o áudio)

    // Função que retorna o texto da opção de resposta baseado no índice
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Mole em pedra dura"
        case 1:
            return "De chuva em abril"
        case 2:
            return "Que não corre"
        case 3:
            return "Que não bebes"
        default:
            return ""
        }
    }

    var body: some View {
        // Pilha de navegação que permite transições entre telas
        NavigationStack {
            ZStack {
                // Definição da cor de fundo da tela
                Color.menu
                    .edgesIgnoringSafeArea(.all) // Garante que a cor de fundo preencha toda a área da tela
                
                VStack {
                    HStack {
                        Spacer()
                    }
                    .padding()
                    
                    // Barra de progresso indicando o avanço da lição
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor) // Cor de fundo da barra
                            .frame(width: 360, height: 25) // Tamanho da barra de progresso
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar) // Cor que preenche a barra para mostrar o progresso
                            .frame(width: 360, height: 25)
                    }
                    .padding(.horizontal)
                    
                    // Texto com instrução da atividade para o usuário
                    Text("Com base na situação representada na imagem, como você completaria o ditado popular apresentado no quadro negro?")
                        .foregroundColor(.white) // Cor do texto
                        .multilineTextAlignment(.center) // Alinhamento centralizado do texto
                        .padding()
                        .frame(height: 90)
                        .font(.system(size: 16))
                        .layoutPriority(1)
                    
                    VStack {
                        // Retângulo branco que destaca o conteúdo central
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                        
                        // Instrução adicional para o usuário
                        Text("Complete o ditado!")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        // Caixa verde contendo as opções de resposta
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    // Ação ao selecionar uma resposta
                                    isCorrect = true // Define se a resposta está correta
                                    showingResult = true // Mostra o resultado
                                    selectedOption = textForIndex(index) // Armazena a opção selecionada
                                }) {
                                    // Texto da opção de resposta
                                    Text(textForIndex(index))
                                        .font(.headline)
                                        .foregroundColor(.black) // Cor do texto
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.botaoOpcao) // Cor de fundo das opções
                                        .cornerRadius(10) // Bordas arredondadas
                                }
                                
                                if index < 3 {
                                    // Divisores entre as opções de resposta
                                    Divider()
                                        .background(Color("botões"))
                                }
                            }
                        }
                        .padding()
                        .background(
                            // Moldura ao redor das opções
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.botaoOpcao) // Fundo das opções
                                )
                        )
                        .padding(.bottom, 20)
                        
                        // Botão de som para tocar as instruções em áudio
                        Button(action: {
                            voiceSynthesizer.speak("Com base na situação representada na imagem, como você completaria o ditado popular apresentado no quadro negro?")
                            voiceSynthesizer.speak("Complete o ditado!")
                        }) {
                            Image(systemName: "speaker.wave.2.fill") // Ícone de som
                                .frame(width: 120, height: 50)
                                .padding()
                                .background(Color.botaoPadrao) // Cor de fundo do botão de som
                                .cornerRadius(10)
                                .foregroundColor(.white) // Cor do ícone de som
                        }
                    }
                    .padding()
                    .overlay(
                        // Exibe o popup de resultado
                        CustomPopupView7(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                    )
                    
                    // Navegação para a próxima tela após a conclusão do desafio
                    NavigationLink(value: navigateToNextScreen) {
                        EmptyView() // View vazia para o link de navegação
                    }
                    .navigationDestination(isPresented: $navigateToNextScreen) {
                        L2Desafio4() // Próxima tela do desafio
                    }
                }
            }
        }
    }
}

// Popup que mostra o feedback ao usuário (se a resposta está correta ou incorreta)
struct CustomPopupView7: View {
    var isCorrect: Bool // Indica se a resposta está correta
    @Binding var showing: Bool // Controla a exibição do popup
    @Binding var navigateToNextScreen: Bool // Controla a navegação para a próxima tela
    private let voiceSynthesizer = VoiceSynthesizer() // Instância do sintetizador de voz para feedback auditivo

    var body: some View {
        if showing {
            VStack {
                HStack {
                    // Ícone que muda conforme o resultado (correto ou incorreto)
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        // Texto de feedback para o usuário
                        Text(isCorrect ? "Excelente! Parabéns!" : "Ops... Na próxima dá certo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    // Botão de som para ouvir o feedback em áudio
                    Button(action: {
                        voiceSynthesizer.speak(isCorrect ? "Excelente! Parabéns!" : "Ôpis... Na próxima dá certo")
                    }) {
                        Image(systemName: "speaker.wave.3.fill") // Ícone de som
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white) // Cor do ícone
                    }
                    .padding()
                    .background(Color.blue) // Fundo azul para o botão de som
                    .cornerRadius(15)
                    .padding()
                    
                    // Botão para avançar para a próxima tela
                    Button(action: {
                        showing = false // Oculta o popup
                        navigateToNextScreen = true // Navega para a próxima tela
                    }) {
                        Image(systemName: "forward.fill") // Ícone de avanço
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black) // Cor do ícone de avanço
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white) // Fundo branco do botão de avançar
                    .cornerRadius(15)
                    .padding(.horizontal, 50)
                }
                .transition(.move(edge: .bottom)) // Animação para o popup aparecer de baixo para cima
                .animation(.easeInOut, value: showing) // Animação de transição suave
            }
        }
    }
}

#Preview {
    L2Desafio3() // Exibe a visualização da tela
}
