import SwiftUI

struct Licao2: View {
    
    @Binding var state: LessonState
    
    @State private var words: [String] = ["Mões", "Universo", "Classes", "Pessoas", "Escolha", "Mãos", "Mundo", "Planeta", "Vidas"]
    @State private var showingPopup = false
    @State private var draggedWord: String? = nil
    @State private var resposta1 = ""
    @State private var resposta2 = ""
    @State private var resposta3 = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var showingResult = false
    @State private var LicaoID = [2]
    
    var body: some View {
//        NavigationStack {
            ZStack {
                Color.menu
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                    }
                    .padding()
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(width: 360, height: 25)
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 144, height: 25)
                    }
                    .padding(.horizontal)
                    
                    Text("Ajude Ana a completar seu cartaz escolhendo as opções certas, Ela solicita auxílio para a conclusão de três frases cruciais.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                            .overlay(
                                VStack {
                                    fraseCompletaView()
                                }
                            )
                        
                        Text("Escolha as palavras corretas!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.top)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.botaoOpcao)
                            VStack {
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                    ForEach(words, id: \.self) { word in
                                        Text(word)
                                            .frame(maxWidth: .infinity, minHeight: 50)
                                            .background(Color.botaoL1D2)
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .onDrag {
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
                    
                    HStack {
                        Button(action: {
                            // Ação para o botão de som
                        }) {
                            Image(systemName: "speaker.3.fill")
                                .frame(width: 100)
                                .padding()
                                .background(Color.botaoPadrao)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        //Botão de validação
                        Button(action: {
                            isCorrect = verificarRespostas() // Verifica as respostas ao clicar no botão
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
                
                // Adicionando o Popup
                if showingResult {
                    CustomPopupViewD2(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                        .transition(.move(edge: .bottom))
                }
                
                NavigationLink(value: navigateToNextScreen) {
                    EmptyView()
                }
                .navigationDestination(isPresented: $navigateToNextScreen) {
//                    Licao3() // Aqui você pode alterar para a próxima lição ou tela desejada
                }
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
//        }
    }

    // Função para verificar se as respostas estão corretas
    func verificarRespostas() -> Bool {
        // Verifica cada resposta individualmente
        let isResposta1Correta = resposta1 == "Mãos"
        let isResposta2Correta = resposta2 == "Pessoas"
        let isResposta3Correta = resposta3 == "Mundo"
        
        // Retorna verdadeiro apenas se todas as respostas forem corretas
        return isResposta1Correta && isResposta2Correta && isResposta3Correta
    }

    @ViewBuilder
    func fraseCompletaView() -> some View {
        VStack(alignment: .leading) {
            fraseCompletarView(textoBase: "Lute pelas", espaco: $resposta1)
            fraseCompletarView(textoBase: "O poder das", espaco: $resposta2, textoPosEspaco: "muda tudo")
            fraseCompletarView(textoBase: "O seu voto mudará o", espaco: $resposta3)
        }
        .padding()
    }
    
//  No momento que esta função foi constrída só duas pessoas sabia
    func fraseCompletarView(textoBase: String, espaco: Binding<String>, textoPosEspaco: String = "") -> some View {
        HStack {
            Text(textoBase)
                .font(.title3)
                .foregroundColor(.black)
            
            Text(espaco.wrappedValue.isEmpty ? "________" : espaco.wrappedValue)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(espaco.wrappedValue.isEmpty ? .gray : .black)
                .onDrop(of: [.text], isTargeted: nil) { providers in
                    if let provider = providers.first {
                        provider.loadObject(ofClass: String.self) { object, _ in
                            if let word = object {
                                // DispatchQueue.main.async é utilizado para rodar este projeto na thread principal de forma assíncrona.
                                DispatchQueue.main.async {
                                    if !espaco.wrappedValue.isEmpty {
                                        words.append(espaco.wrappedValue)
                                    }
                                    espaco.wrappedValue = word
                                    if let index = words.firstIndex(of: word) {
                                        words.remove(at: index)
                                    }
                                }
                            }
                        }
                        return true
                    }
                    return false
                }
                .onTapGesture {
                    if !espaco.wrappedValue.isEmpty {
                        words.append(espaco.wrappedValue)
                        espaco.wrappedValue = ""
                    }
                }
            
            if !textoPosEspaco.isEmpty {
                Text(textoPosEspaco)
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
    }
}

struct CustomPopupViewD2: View {
    var isCorrect: Bool
    @Binding var showing: Bool
    @Binding var navigateToNextScreen: Bool
    
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
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
            .padding()
            
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

#Preview {
    Licao2(state: .constant(.init()))
}
