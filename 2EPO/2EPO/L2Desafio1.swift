import SwiftUI

// Definição da tela principal da lição
struct L2Desafio1: View {
    // Propriedades de estado (controlam o estado da interface e lógica do jogo)
    @State private var showingPopup = false // Controla se o popup está visível
    @State private var selectedOption = "" // Armazena a opção selecionada pelo usuário
    @State private var navigateToNextScreen = false // Controla a navegação para a próxima tela
    @State private var isCorrect = false // Indica se a resposta escolhida está correta
    @State private var showingResult = false // Controla a exibição do resultado
    private let voiceSynthesizer = VoiceSynthesizer() // Instância para síntese de voz (para fala)

    // Função que retorna o texto da opção de resposta com base no índice
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Do que 2 no ninho"
        case 1:
            return "Do que 2 voando"
        case 2:
            return "Do que 2 caindo"
        case 3:
            return "Do que 2 boiando"
        default:
            return ""
        }
    }

    var body: some View {
        NavigationStack { // Pilha de navegação
            ZStack {
                // Definição da cor de fundo da tela
                Color.menu
                    .edgesIgnoringSafeArea(.all) // Garante que a cor de fundo preencha toda a tela
                
                VStack {
                    HStack {
                        Spacer()
                    }
                    .padding()
                    
                    // Barra de progresso para indicar a etapa da lição
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor) // Cor de fundo da barra
                            .frame(width: 360, height: 25) // Tamanho da barra de progresso
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar) // Cor que preenche a barra para indicar progresso
                            .frame(width: 360, height: 25)
                    }
                    .padding(.horizontal)
                    
                    // Texto de instrução da atividade
                    Text("Uma jovem pede a sua avó exemplos de ditados populares. Ela inicia o ditado “Mais vale um pássaro na mão”, convidando o jovem a completá-lo")
                        .foregroundColor(.white) // Cor do texto
                        .multilineTextAlignment(.center) // Alinhamento centralizado
                        .padding()
                        .frame(height: 90)
                        .font(.system(size: 15))
                        .layoutPriority(1)
                    
                    VStack {
                        // Retângulo branco que serve como destaque para o conteúdo
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                        
                        // Texto de instrução para o usuário
                        Text("Complete o ditado !")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        // Caixa contendo as opções de resposta
                        VStack(spacing: 0) {
                            // Loop para exibir 4 opções de resposta (0 a 3)
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    isCorrect = true // Define se a resposta está correta (lógica básica)
                                    showingResult = true // Exibe o resultado
                                    selectedOption = textForIndex(index) // Armazena a opção selecionada
                                }) {
                                    // Texto da opção de resposta
                                    Text(textForIndex(index))
                                        .font(.headline)
                                        .foregroundColor(.black) // Cor do texto
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.botaoOpcao) // Fundo da opção
                                        .cornerRadius(10) // Bordas arredondadas
                                }
                                
                                if index < 3 {
                                    Divider() // Divisores entre as opções
                                        .background(Color("botões"))
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 2) // Borda das opções
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.botaoOpcao) // Cor de fundo das opções
                                )
                        )
                        .padding(.bottom, 20)
                        
                        // Botão de som para o usuário ouvir as instruções
                        Button(action: {
                            voiceSynthesizer.speak("Uma jovem pede a sua avó exemplos de ditados populares. Ela inicia o ditado “Mais vale um pássaro na mão”, convidando o jovem a completá-lo")
                            voiceSynthesizer.speak("Complete o ditado!")
                        }) {
                            Image(systemName: "speaker.wave.2.fill") // Ícone de som
                                .frame(width: 120, height: 50)
                                .padding()
                                .background(Color.botaoPadrao) // Cor do botão
                                .cornerRadius(10)
                                .foregroundColor(.white) // Cor do ícone
                        }
                    }
                    .padding()
                    .overlay(
                        // Exibe o popup quando o resultado é revelado
                        CustomPopupView5(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                    )
                    
                    // Navegação para a próxima tela
                    NavigationLink(value: navigateToNextScreen) {
                        EmptyView() // Exibe uma view vazia para o link de navegação
                    }
                    .navigationDestination(isPresented: $navigateToNextScreen) {
                        L2Desafio2() // Próxima tela após o desafio
                    }
                    
                }
            }
        }
    }
}

// Popup personalizado que mostra o resultado ao usuário (correto ou incorreto)
struct CustomPopupView5: View {
    var isCorrect: Bool // Indica se a resposta está correta
    @Binding var showing: Bool // Controla se o popup é exibido
    @Binding var navigateToNextScreen: Bool // Controla a navegação para a próxima tela
    private let voiceSynthesizer = VoiceSynthesizer() // Instância para síntese de voz

    var body: some View {
        if showing {
            VStack {
                HStack {
                    // Ícone que indica sucesso ou erro
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        // Mensagem de feedback para o usuário
                        Text(isCorrect ? "Excelente! Parabéns!" : "Ops... Na próxima dá certo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    // Botão de som para ouvir o feedback
                    Button(action: {
                        voiceSynthesizer.speak(isCorrect ? "Excelente! Parabéns!" : "Ôpis... Na próxima dá certo")
                    }) {
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue) // Cor do fundo do botão de som
                    .cornerRadius(15)
                    .padding()
                    
                    // Botão para avançar para a próxima lição
                    Button(action: {
                        showing = false // Oculta o popup
                        navigateToNextScreen = true // Navega para a próxima tela
                    }) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
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
    L2Desafio1() // Exibe a visualização da tela
}
