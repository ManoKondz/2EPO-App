//
//  TrilhaView.swift
//  2EPO
//
//  Created by found on 21/05/24.
//
import SwiftUI

struct TrilhaView: View {
    @State private var showingPopup = false
    @State private var selectedLesson = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack(alignment: .leading) {
                    HStack() {
                        Image(systemName:"person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("João")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Aluno")
                                .font(.title3)
                        }
                    }
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(0..<6) { index in
                                HStack {
                                    if index % 2 == 0 {
                                        VStack {
                                            HStack {
                                                CircleIconView(index: index)
                                                    .onTapGesture {
                                                        self.selectedLesson = getLessonTitle(index: index)
                                                        self.showingPopup.toggle()
                                                    }
                                                Spacer() // Empurra a imagem para a esquerda
                                            }
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(index % 2 == 0 ? Color.black : Color.blue)
                                                .frame(width: 250, height: 20)
                                                .rotationEffect(.degrees(index % 2 == 0 ? 35 : -35))
                                                .zIndex(-1)
                                            
                                        }
                                    } else {
                                        VStack {
                                            HStack {
                                                Spacer() // Empurra a imagem para a direita
                                                CircleIconView(index: index)
                                                    .onTapGesture {
                                                        self.selectedLesson = getLessonTitle(index: index)
                                                        self.showingPopup.toggle()
                                                    }
                                            }
                                            if index < 5 {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(index % 2 == 0 ? Color.black : Color.blue)
                                                    .frame(width: 250, height: 20)
                                                    .rotationEffect(.degrees(index % 2 == 0 ? 35 : -35))
                                                    .zIndex(-1)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.background)
                    }
                    .frame(maxHeight: .infinity)
                }
                
                .background(Color.menu)
                if showingPopup {
                    LessonPopupView(lessonName: selectedLesson, isShowingPopup: $showingPopup)
                }
            }
        }
        .tabItem {
            Image(systemName: "list.dash")
            Text("Trilha")
        }
    }
    
    func getLessonTitle(index: Int) -> String {
        switch index {
        case 0:
            return "Lição 1: A batalha pela verdadeira palavra."
        case 1:
            return "Lição 2: Através de Ditados Populares."
        case 2:
            return "Lição 3: O mistério do Ônibus."
        case 3:
            return "Lição 4: Lição Extra/Complementar."
        case 4:
            return "Lição 5: Lição Extra/Complementar."
        case 5:
            return "Lição 6: Lição Extra/Complementar."
        default:
            return "Lição \(index + 1)"
        }
    }
}

struct CircleIconView: View {
    var index: Int
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.botões)
                .frame(width: 100, height: 100)
            Image(systemName: getSystemImageName(index))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
        }
    }
    
    func getSystemImageName(_ index: Int) -> String {
        switch index {
        case 0:
            return "hand.raised.fill"
        case 1:
            return "airplane"
        case 2:
            return "bus.fill"
            // Adicionar mais cases conforme necessário
        default:
            return "circle.fill"
        }
    }
}

struct LessonPopupView: View {
    var lessonName: String
    @Binding var isShowingPopup: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isShowingPopup = false
                }) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                }
                .padding(.leading, 20)
                .padding(.top, 20)
                Spacer()
            }
            
            Text(lessonName)
                .font(.title)
                .padding(.top, 20) // Ajustei aqui para alinhar o texto um pouco mais acima
                .padding(.horizontal, 20)
            
            Button(action: {
                // Adicionar a ação para iniciar a lição
                self.isShowingPopup = false
            }) {
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.green)
            .clipShape(Circle())
            
            Spacer()
        }
        .frame(width: 300, height: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(.top, 20) // Outro ajuste para mover todo o conteúdo da VStack um pouco mais para cima
    }
}

#Preview {
    TabView {
        TrilhaView()
    }
}
