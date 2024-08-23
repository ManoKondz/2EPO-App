import SwiftUI

struct Licao3: View {
    @State private var showingPopup = false
    @State private var selectedOption = ""
    
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return " Aumento de salários para os trabalhadores"
        case 1:
            return "Proteção do meio ambiente"
        case 2:
            return "Reformas na legislação educacional"
        case 3:
            return " Qual seria o plural certo de mão"
        default:
            return ""
        }
    }
    
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
                            Text("voltar")
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    // Barra de progresso
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(height: 25) // Define altura da barra de fundo
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progress)
                            .frame(width: 150, height: 25) // A largura é ajustada com base no progresso
                    }
                    .padding(.horizontal)
                    
                    Text("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um `slogan`.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 90)
                        .font(.system(size: 16))
                        .layoutPriority(1)
                    
                    VStack{
                        // Retângulo branco
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                            
                        
                        Text("Selecione o `slogan` mais apropriado.")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        // Caixa verde das respostas
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    selectedOption = textForIndex(index)
                                }) {
                                    Text(textForIndex(index))
                                        .font(.system(size: 15))
                                        .foregroundColor(.black)
                                        .frame(height: 10)
                                        .padding()
                                        .background(Color.botões)
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
                                        .fill(Color.botões)
                                )
                        )
                        .padding(.bottom, 20)
                        
                        // Botão de som
                        Button(action: {
                            // Ação do botão de som
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .frame(width: 120, height: 50)
                                .padding()
                                .background(Color.botãof)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
            }
        }
    }}

#Preview {
    Licao3()
}
