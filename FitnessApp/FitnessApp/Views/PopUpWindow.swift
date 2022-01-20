//
//  PopUpWindow.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/20/22.
//

import SwiftUI

struct PopUpWindow: View {
    var title: String
    var message: String
    var buttonText: String
    
    @Binding var show: Bool

    var body: some View {
        ZStack {
            if show {
                Color.black
                    .opacity(show ? 0.3 : 0)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.black)

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding()
                        .foregroundColor(Color.black)

                    Divider()
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(Color.blue)
                            .font(Font.system(size: 23, weight: .semibold))
                    })
                }
                .frame(maxWidth: 300)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 2))
                .background(RoundedRectangle(cornerRadius: 14)
                                .fill(Color("lightGray")))
                
            }
        }
    }
}

struct PopUpWindow_Previews: PreviewProvider {
    static var previews: some View {
        PopUpWindow(title: "Error", message: "Incorrect email or password!", buttonText: "Okay", show: .constant(true))
    }
}
