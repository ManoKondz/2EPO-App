import SwiftUI

struct Licao1: View {
    @State private var showingResult = false
    @State private var isCorrect = false
    @State private var navigateToNextScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.menu
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(height: 25)
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 72, height: 25)
                    }
                    .padding(.horizontal)
                    
                    Text("Dois grupos estão discutindo qual a forma correta de escrever a palavra \"mão\" no plural")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    
                    Image("boxers")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .foregroundColor(.black)
                    
                    Text("Declare apoio ao grupo correto")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .padding()
                    
                    
                    //Botões de resposta: Mões e Mãos
                    HStack(spacing: 20) {
                        Button(action: {
                            isCorrect = false
                            showingResult = true
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
                            .background(Color.botaoOpcao)
                            .cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            isCorrect = true
                            showingResult = true
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
                    
                    Button(action: {
                        // Ação do botão de som
                    }) {
                        Image(systemName: "speaker.3.fill")
                            .frame(width: 100)
                            .padding()
                            .background(Color.botaoPadrao)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                }
                .padding()
                .overlay(
                    CustomPopupView(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                )
                
                NavigationLink(value: navigateToNextScreen)
                    {
                    EmptyView()
                }
                    .navigationDestination(isPresented:$navigateToNextScreen){
                        Licao2()
                    }
            }
        }
    }
}

struct CustomPopupView: View {
    var isCorrect: Bool
    @Binding var showing: Bool
    @Binding var navigateToNextScreen: Bool
    
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
                    navigateToNextScreen = true // Ativar navegação para a próxima tela
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



#Preview {
    Licao1()
}
