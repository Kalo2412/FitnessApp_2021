//
//  HomePageView.swift
//  FitnessApp
//
//  Created by Stefania Tsvetkova on 1/19/22.
//

import SwiftUI

struct HomePageView: View {
    @State var currentDate: Date = Date()
    @State var addFriendWindowToShow: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                VStack(spacing: 20) {
                    TrainingCalendar(currentDate: $currentDate)
                }
                .padding(.vertical)
                ZStack {
                    if addFriendWindowToShow {
                        AddNewTraining(addFriendWindow: $addFriendWindowToShow)
                            .padding(.top, 120)
                            .padding(.horizontal, 50)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    }
                }
                .zIndex(2.0)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .overlay(
            Button {
                addFriendWindowToShow = true
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 80)
                    .background(Color("darkGreen").cornerRadius(50).opacity(0.5))
                    .padding()
            }, alignment: .bottomLeading
        )
    }
}

struct AddNewTraining: View {
    @Binding var addFriendWindow: Bool
    @State private var newTraining: TrainingMetaData = TrainingMetaData(training: [], trainingDate: Date())
    @State private var newTrainingTitle: String = ""
    var body: some View {
        ZStack {
            Color("skyGreen")
            VStack {
                HStack {
                    Text("Add new friend")
                        .font(.title.bold())
                    Spacer()
                    Button {
                        trainings.append(newTraining)
                        addFriendWindow = false
                    } label: {
                        Text("Done")
                            .font(.title2)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                Form {
                    Section(header: Text("Choose new training date")) {
                        DatePicker("TrainingDate", selection: $newTraining.trainingDate, in: Date()...)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    Section(header: Text("Add trainings")) {
                        ForEach(newTraining.training) { training in
                            Text(training.title)
                        }
                        .onDelete { indices in
                            newTraining.training.remove(atOffsets: indices)
                        }
                        HStack {
                            TextField("New Training", text: $newTrainingTitle)
                            Button(action: {
                                withAnimation {
                                    let training = Training(title: newTrainingTitle, time: newTraining.trainingDate)
                                    newTraining.training.append(training)
                                    newTrainingTitle = ""
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                            .disabled(newTrainingTitle.isEmpty)
                        }
                    }
                }
                
            }
        }
        .cornerRadius(30)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        //AddNewTraining(addFriendWindow: .constant(false))
        HomePageView()
            .environmentObject(StateManager())
    }
}
