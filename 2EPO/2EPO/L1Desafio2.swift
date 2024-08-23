import SwiftUI

struct Licao2: View {
    @State private var showingPopup = false
    @State private var selectedOption = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.menu // Cor de fundo aplicada a toda a tela
                    .edgesIgnoringSafeArea(.all) // Garante que a cor preencha toda a tela
                
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            // Ação do botão Voltar
                        }) {
                            Text("voltar")
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    // Código da barra de progresso (ainda a adicionar a função de aumentar com a questão)
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(height: 25) // Define altura da barra de fundo
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progress)
                            .frame(width: 99, height: 25) // A largura é ajustada com base no progresso
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
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.botões)
                            VStack{
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                    ForEach(["Mões", "Universo", "Classes", "Pessoas", "Escolha", "Mãos", "Mundo", "Planeta", "Vidas"], id: \.self) { word in
                                        Button(action: {
                                            // Ação do botão
                                        }) {
                                            Text(word)
                                                .frame(maxWidth: .infinity, minHeight: 50)
                                                .background(Color.botãol1D2)
                                                .cornerRadius(10)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Botões de som e aprovação
                    HStack {
                        Button(action: {
                            // Ação para o primeiro botão
                        }) {
                            Image(systemName: "speaker.3.fill")
                            
                                .frame(width: 100)
                                .padding()
                                .background(Color.botãof)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Ação para o segundo botão
                        }) {
                            Image(systemName: "hand.thumbsup.fill")
                            
                                .frame(width: 100)
                                .padding()
                                .background(Color.botãof)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 55)
                }
                .padding(.bottom)
            }
        }
    }
}

@ViewBuilder
func fraseCompletaView() -> some View {
    VStack(alignment: .leading) {
        fraseCompletarView(textoBase: "Lute pelas", espaco: "________")
        fraseCompletarView(textoBase: "O poder da", espaco: "________", textoPosEspaco: "muda tudo")
        fraseCompletarView(textoBase: "O seu voto mudará o", espaco: "________")
    }
    .padding()
}

func fraseCompletarView(textoBase: String, espaco: String, textoPosEspaco: String = "") -> some View {
    HStack {
        Text(textoBase)
            .font(.title3)
            .foregroundColor(.black)
        
        Text(espaco)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.gray)
        
        if !textoPosEspaco.isEmpty {
            Text(textoPosEspaco)
                .font(.title2)
                .foregroundColor(.black)
        }
    }
}


#Preview {
    Licao2()
}

