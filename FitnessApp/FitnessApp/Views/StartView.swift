//
//  StartView.swift
//  FitnessApp
//
//  Created by Kaloyan Vachkov on 19.01.22.
//

import SwiftUI

struct StartView: View {
    @State private var isActivated = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("startImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                VStack(spacing: 15) {
                    Text("Welcome")
                        .font(.system(size: 60, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: RegisterAndLoginView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Image(systemName: "person")
                                .font(.title)
                            Text("Login")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("darkGreen"),Color.green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        .shadow(radius: 5.0)
                    }
                    NavigationLink(destination: RegisterAndLoginView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .font(.title)
                            Text("Register")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    }
                }
                .frame(width: 300, height: 600)
                .navigationBarHidden(true)
                .navigationTitle("")
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
            StartView()
    }
}
