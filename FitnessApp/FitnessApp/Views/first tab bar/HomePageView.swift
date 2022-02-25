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
    
    @ObservedObject var allTrainings = AllTrainingsModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                VStack(spacing: 20) {
                    TrainingCalendar(currentDate: $currentDate, allTrainings: $allTrainings.trainings)
                }
                .padding(.vertical)
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
        .blur(radius: addFriendWindowToShow ? 3 : 0)
        .overlay(
            ZStack {
                if addFriendWindowToShow {
                    AddNewTraining(addFriendWindow: $addFriendWindowToShow, allTrainings: $allTrainings.trainings)
                        .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("darkGreen"), lineWidth: 2)
                        )
                        .padding(.top, 50)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 50)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                }
            }
        )
    }
}

struct AddNewTraining: View {
    @EnvironmentObject var stateManager: StateManager
    
    @Binding var addFriendWindow: Bool
    @State private var newTraining: TrainingModel = TrainingModel(id: "", title: "", description: "", time: Date())
    @State private var newTrainingTitle: String = ""
    @State private var newTrainingDescription: String = ""
    @State private var newTrainingDate: Date = Date()
    
    @Binding var allTrainings: [TrainingModel]
    
    var body: some View {
        ZStack {
            Color("skyGreen")
            VStack {
                HStack {
                    Text("Add new friend")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        allTrainings.append(newTraining)
                        addFriendWindow = false
                    } label: {
                        Text("Done")
                            .font(.title2)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                Form {
                    Section(header: Text("Date and time:")) {
                        DatePicker("TrainingDate", selection: $newTrainingDate, in: Date()...)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    Section(header: Text("Description:")) {
                        TextField("Description", text: $newTrainingDescription)
                    }
                    Section(header: Text("Add trainings")) {
                        /*ForEach(newTraining.training) { training in
                            Text("\(training.title): \(training.description)")
                        }
                        .onDelete { indices in
                            newTraining.training.remove(atOffsets: indices)
                        }*/
                        HStack {
                            TextField("New Training", text: $newTrainingTitle)
                            Button(action: {
                                withAnimation {
                                    let training = TrainingModel(id: UUID().uuidString, title: newTrainingTitle, description: newTrainingDescription, time: newTrainingDate)
                                    allTrainings.append(training)
                                    
                                    FirebaseManager.instance.firestore.collection("users").document(stateManager.loggedUser.uid).collection("trainings").document(training.id)
                                        .setData(["title": newTrainingTitle,
                                                  "description": newTrainingDescription,
                                                  "time": newTrainingDate])
                                        { error in
                                            if error != nil {
                                                print("Error saving training")
                                            }
                                        }
                                    
                                    newTrainingTitle = ""
                                    newTrainingDescription = ""
                                    newTrainingDate = Date()
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
