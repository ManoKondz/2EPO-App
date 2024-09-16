import SwiftUI

struct L1Desafio3: View {
    
    @Binding var state: LessonState
    
    @State private var showingPopup = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var showingResult = false
    @State private var respostacerta = "Qual seria o plural certo de mão"
    @State private var LicaoID = [3]
    
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Aumento de salários para os trabalhadores"
        case 1:
            return "Proteção do meio ambiente"
        case 2:
            return "Reformas na legislação educacional"
        case 3:
            return "Qual seria o plural certo de mão"
        default:
            return ""
        }
    }
    
    var body: some View {
       // NavigationStack {
            ZStack {
                Color.menu.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(height: 25)
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 216, height: 25)
                    }
                    .padding(.horizontal)
                    
                    Text("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um slogan.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 90)
                        .font(.system(size: 16))
                        .layoutPriority(1)
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                        
                        Text("Selecione o slogan mais apropriado.")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    // Logica para saber se a resposta escolhida é a certa
                                    if selectedOption != respostacerta{
                                        isCorrect = false
                                    } else{
                                        isCorrect = true
                                    }
                                    showingResult = true
                                }) {
                                    Text(textForIndex(index))
                                        .font(.system(size: 15))
                                        .foregroundColor(.black)
                                        .frame(height: 10)
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
                        
                        Button(action: {
                            // Ação do botão de som
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .frame(width: 100)
                                .padding()
                                .background(Color.botaoPadrao)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .overlay(
                        CustomPopupView3(isCorrect: isCorrect, showing: $showingResult, navigateToNextScreen: $navigateToNextScreen)
                    )
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
                }
            }
        //}
    }
    
    struct CustomPopupView3: View {
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
    L1Desafio3(state: .constant(.init()))
}
