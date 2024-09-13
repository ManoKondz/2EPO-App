import SwiftUI

// Definição da view "Licao2", que representa a segunda lição.
struct Licao2: View {
    // Estados para gerenciar as palavras, interações do usuário e a navegação.
    @State private var words: [String] = ["Mões", "Universo", "Classes", "Pessoas", "Escolha", "Mãos", "Mundo", "Planeta", "Vidas"]
    @State private var showingPopup = false
    @State private var draggedWord: String? = nil
    @State private var resposta1 = "" // Armazena a resposta para a primeira frase.
    @State private var resposta2 = "" // Armazena a resposta para a segunda frase.
    @State private var resposta3 = "" // Armazena a resposta para a terceira frase.
    @State private var navigateToNextScreen = false // Controla a navegação para a próxima tela.
    @State private var isCorrect = false // Indica se a resposta do usuário está correta.
    @State private var showingResult = false // Controla a exibição do popup de resultado.
    
    private let voiceSynthesizer = VoiceSynthesizer() // Criando uma instância da classe sintetizadora de voz (a ser implementada).
    
    var body: some View {
        // Criação de uma pilha de navegação para controlar transições entre telas.
        NavigationStack {
            ZStack {
                Color.menu // Cor de fundo da tela.
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                    }
                    .padding()
                    
                    // Barra de progresso indicando o avanço da lição.
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(width: 360, height: 25)
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 144, height: 25)
                    }
                    .padding(.horizontal)
                    
                    // Texto que instrui o usuário sobre a atividade.
                    Text("Ajude Ana a completar seu cartaz escolhendo as opções certas, Ela solicita auxílio para a conclusão de três frases cruciais.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    VStack {
                        // Exibe as frases com espaços em branco para completar.
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                            .overlay(
                                VStack {
                                    fraseCompletaView() // Chama a função que constrói as frases.
                                }
                            )
                        
                        Text("Escolha as palavras corretas!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.top)
                        
                        // Área onde as palavras para arrastar são exibidas.
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.botaoOpcao)
                            
                            VStack {
                                // Grelha com palavras que podem ser arrastadas para completar as frases.
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                    ForEach(words, id: \.self) { word in
                                        Text(word)
                                            .frame(maxWidth: .infinity, minHeight: 50)
                                            .background(Color.botaoL1D2)
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .onDrag {
                                                // A palavra sendo arrastada é armazenada em "draggedWord".
                                                self.draggedWord = word
                                                return NSItemProvider(object: word as NSString)
                                            }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Botões para ouvir as frases e verificar as respostas.
                    HStack {
                        // Botão de sons muito agudos.
                        Button(action: {
                            voiceSynthesizer.speak("Ajude Ana a completar seu cartaz escolhendo as opções certas, Ela solicita auxílio para a conclusão de três frases cruciais.")
                            voiceSynthesizer.speak("Escolha as palavras corretas")
                        }) {
                            Image(systemName: "speaker.3.fill")
                                .frame(width: 100)
                                .padding()
                                .background(Color.botaoPadrao)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        // Botão para validar as respostas.
                        Button(action: {
                            // Verifica se as respostas estão corretas e exibe o popup de resultado.
                            isCorrect = verificarRespostas()
                            showingResult = true
                        }) {
                            Image(systemName: "hand.thumbsup.fill")
                                .frame(width: 100)
                                .padding()
                                .background(Color.botaoPadrao)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 55)
                }
                .padding(.bottom)
                
                // Popup de feedback para o usuário.
                if showingResult {
                    CustomPopupViewD2(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut)
                }
                
                // Link de navegação para a próxima tela, que será "Licao3".
                NavigationLink(value: navigateToNextScreen) {
                    EmptyView()
                }
                .navigationDestination(isPresented: $navigateToNextScreen) {
                    Licao3() // Próxima lição ou tela desejada.
                }
            }
        }
    }
    
    // Função para verificar se as respostas estão corretas.
    func verificarRespostas() -> Bool {
        // Verifica individualmente se cada resposta está correta.
        let isResposta1Correta = resposta1 == "Mãos"
        let isResposta2Correta = resposta2 == "Pessoas"
        let isResposta3Correta = resposta3 == "Mundo"
        
        // Retorna verdadeiro apenas se todas as respostas forem corretas.
        return isResposta1Correta && isResposta2Correta && isResposta3Correta
    }
    
    // Função para construir as frases com os espaços para serem completados.
    @ViewBuilder
    func fraseCompletaView() -> some View {
        VStack(alignment: .leading) {
            // Chamadas à função que cria cada frase com espaço para completar.
            fraseCompletarView(textoBase: "Lute pelas", espaco: $resposta1)
            fraseCompletarView(textoBase: "O poder das", espaco: $resposta2, textoPosEspaco: "muda tudo")
            fraseCompletarView(textoBase: "O seu voto mudará o", espaco: $resposta3)
        }
        .padding()
    }
    
    // Função que cria uma frase com texto fixo e um espaço interativo para completar com uma palavra.
    func fraseCompletarView(textoBase: String, espaco: Binding<String>, textoPosEspaco: String = "") -> some View {
        HStack {
            // Texto fixo antes do espaço em branco.
            Text(textoBase)
                .font(.title3)
                .foregroundColor(.black)
            
            // Espaço onde a palavra escolhida será exibida, ou um espaço em branco se não houver palavra selecionada.
            Text(espaco.wrappedValue.isEmpty ? "________" : espaco.wrappedValue)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(espaco.wrappedValue.isEmpty ? .gray : .black)
                .onDrop(of: [.text], isTargeted: nil) { providers in
                    // Gerencia o evento de arrastar e soltar palavras.
                    if let provider = providers.first {
                        provider.loadObject(ofClass: String.self) { object, _ in
                            if let word = object {
                                // Atualiza a palavra no espaço correto.
                                DispatchQueue.main.async {
                                    if !espaco.wrappedValue.isEmpty {
                                        words.append(espaco.wrappedValue) // Reinsere a palavra antiga de volta na lista de opções.
                                    }
                                    espaco.wrappedValue = word
                                    if let index = words.firstIndex(of: word) {
                                        words.remove(at: index) // Remove a palavra selecionada da lista de opções.
                                    }
                                }
                            }
                        }
                        return true
                    }
                    return false
                }
                .onTapGesture {
                    // Ao tocar no espaço, a palavra atual é removida e recolocada na lista de opções.
                    if !espaco.wrappedValue.isEmpty {
                        words.append(espaco.wrappedValue)
                        espaco.wrappedValue = ""
                    }
                }
            
            // Texto adicional após o espaço, se houver.
            if !textoPosEspaco.isEmpty {
                Text(textoPosEspaco)
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
    }
}

// Popup que exibe feedback sobre a resposta do usuário.
struct CustomPopupViewD2: View {
    var isCorrect: Bool
    @Binding var showing: Bool
    @Binding var navigateToNextScreen: Bool
    private let voiceSynthesizer = VoiceSynthesizer() // Criando uma instância da classe VoiceSynthesizer
    
    
    var body: some View {
        VStack {
            HStack {
                // Ícone que indica se a resposta foi correta ou incorreta.
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
                // Botão para avançar para a próxima lição ou tela.
                Button(action: {
                    showing = false
                    navigateToNextScreen = true
                }) {
                    Text("Avançar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 50)
            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}

// Pré-visualização da tela "Licao2".
#Preview {
    Licao2()
}
