import SwiftUI


struct CustomSheetView: View {
    var isCorrect: Bool
    var onDismiss: () -> Void
    private let voiceSynthesizer = VoiceSynthesizer()
    
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
                
                Button(action: {
                    voiceSynthesizer.speak(isCorrect ? "Excelente! Parabéns!" : "Ôpis... Na próxima dá certo")
                }) {
                    Image(systemName: "speaker.wave.3.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
            .padding()
            
            Button(action: {
                onDismiss()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ajusta a frame para preencher o espaço disponível
        .background(Color.blue) // Define a cor de fundo da CustomSheetView
    }
}
