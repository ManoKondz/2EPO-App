import SwiftUI

struct Licao1: View {
    @State private var showingPopup = false
    @State private var selectedOption = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.menu // Cor de fundo aplicada a toda a tela
                    .edgesIgnoringSafeArea(.all) // Garante que a cor preencha toda a tela
                
                VStack {
                    HStack {
                        Button(action: {
                            // Ação do botão Voltar
                        }) {
                            Text("Voltar")
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    //Codigo da barra de progresso(ainda a adicionar a função de aumentar com a questão)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(height: 25) // Define altura da barra de fundo

                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progress)
                            .frame(width: 66, height: 25) // A largura é ajustada com base no progresso
                    }
                    .padding(.horizontal)
                    
                    Text("Dois grupos estão discutindo qual a forma correta de escrever a palavra \"mão\" no plural")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Image("boxers")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 200)
                        .padding()
                        .background(Color.botões)
                        .cornerRadius(30)
                        .foregroundColor(.black)
                    
                    Text("Declare apoio ao grupo correto")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .padding()
                    
                    HStack(spacing: 20) {
                        // Botão "Mões"
                        Button(action: {
                            // Ação do botão "Mões"
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
                            .background(Color.botões)
                            .cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        }
                        
                        // Botão "Mãos"
                        Button(action: {
                            // Ação do botão "Mãos"
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
                            .background(Color.botões)
                            .cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Botão de som
                    Button(action: {
                        // Ação do botão de som
                    }) {
                        Image(systemName: "speaker.3.fill")
                            .frame(width: 100)
                            .padding()
                            .background(Color.botãof)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
        }
    }
}

#Preview {
    Licao1()
}
