//
//  Lição1.swift
//  2EPO
//
//  Created by found on 26/07/24.
//

import SwiftUI

struct Lic_a_o1: View {
    @State private var showingPopup = false
    @State private var selectedOption = ""
    @State private var progress: Double = 0.5
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(alignment: .leading){
                    
                    HStack(){
                        Button(action:{
                            
                        }) {
                            Text("Voltar")
                        }
                        Spacer()
                    }
                    .padding()
                    
                    
                    ProgressView(value: progress)
                        .padding([.leading, .trailing])
                    Text("Dois grupos estão discutindo qual a forma correta de escrever a palavra \"mão\" no plural")
                        .multilineTextAlignment(.center)
                        .padding()
                    Image("boxers")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Declare apoio ao grupo correto")
                        .font(.headline)
                        .padding()
                    HStack {
                                    Button(action: {
                                        // Ação do botão "Mões"
                                    }) {
                                        Text("Mões")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.green)
                                            .cornerRadius(10)
                                            .foregroundColor(.black)
                                    }
                                    
                                    Button(action: {
                                        // Ação do botão "Mãos"
                                    }) {
                                        Text("Mãos")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.green)
                                            .cornerRadius(10)
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding()
                            }
                            .padding()
                }
            .background(Color.menu)
                    }
            
            
            
        }
    }

#Preview {
    Lic_a_o1()
}
