import SwiftUI

struct Licao2: View {
    @State private var words: [String] = ["Mões", "Universo", "Classes", "Pessoas", "Escolha", "Mãos", "Mundo", "Planeta", "Vidas"]
    @State private var showingPopup = false
    @State private var draggedWord: String? = nil
    @State private var resposta1 = ""
    @State private var resposta2 = ""
    @State private var resposta3 = ""
    
    var body: some View {
        NavigationStack {
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
                            .fill(Color.progress)
                            .frame(width: 144, height: 25)
                    }
                    .padding(.horizontal)
                    
                    Text("Ajude Ana a completar seu cartaz escolhendo as opções certas, Ela solicita auxílio para a conclusão de três frases cruciais.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.botões)
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
                                .fill(Color.botões)
                            VStack {
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                    ForEach(words, id: \.self) { word in
                                        Text(word)
                                            .frame(maxWidth: .infinity, minHeight: 50)
                                            .background(Color.botãol1D2)
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
                                .background(Color.botãof)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            Licao3()
                        } label: {
                            VStack {
                                Image(systemName: "hand.thumbsup.fill")
                                    .frame(width: 100)
                                    .padding()
                                    .background(Color.botãof)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal, 55)
                }
                .padding(.bottom)
            }
        }
    }

    @ViewBuilder
    func fraseCompletaView() -> some View {
        VStack(alignment: .leading) {
            fraseCompletarView(textoBase: "Lute pelas", espaco: $resposta1)
            fraseCompletarView(textoBase: "O poder da", espaco: $resposta2, textoPosEspaco: "muda tudo")
            fraseCompletarView(textoBase: "O seu voto mudará o", espaco: $resposta3)
        }
        .padding()
    }

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
                            if let word = object as? String {
                                DispatchQueue.main.async {
                                    if !espaco.wrappedValue.isEmpty {
                                        // Devolve a palavra anterior para a lista
                                        words.append(espaco.wrappedValue)
                                    }
                                    espaco.wrappedValue = word
                                    // Remove a palavra usada da lista
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
                    // Remover palavra do espaço quando clicado e devolvê-la à lista
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

#Preview {
    Licao2()
}
