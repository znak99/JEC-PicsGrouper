//
//  DetailView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var title: String
    @State var update: String
    @State var pics: [UIImage]
    @State var isVertical = true
    @State var showAlert = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: PhotoGroup.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoGroup.date, ascending: true)])
    var photoGroup: FetchedResults<PhotoGroup>
    
    @FetchRequest(
        entity: PhotoGroupDate.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoGroupDate.date, ascending: false)])
    var photoGroupDate: FetchedResults<PhotoGroupDate>
    
    var body: some View {
        ZStack {
            Color.customWhite.ignoresSafeArea()
            VStack {
                PageTitle(title: title)
                
                Button(action: { dismiss() }) {
                    DismissButton()
                }
                .padding(.trailing)
                HStack {
                    Spacer()
                    Text("作成日　\(update)")
                        .font(.custom(notosansLight, size: UIScreen.screenWidth / 28))
                        .foregroundColor(Color.customBlack)
                }
                .padding([.trailing, .top])
                HStack {
                    Button(action: {
                        showAlert.toggle()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color.red)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Picker("", selection: $isVertical) {
                        Text("V").tag(true)
                        Text("H").tag(false)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: UIScreen.screenWidth / 3)
                }
                .padding()
                if isVertical {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(pics, id: \.self) { pic in
                                Image(uiImage: pic)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .frame(width: UIScreen.screenWidth / 1.5, height: UIScreen.screenWidth / 1.5)
                                    .cornerRadius(5)
                                    .shadow(color: Color.customPrimary, radius: 5)
                                    .padding()
                            }
                        }
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(pics, id: \.self) { pic in
                                Image(uiImage: pic)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .frame(width: UIScreen.screenWidth / 1.5, height: UIScreen.screenWidth / 1.5)
                                    .cornerRadius(5)
                                    .shadow(color: Color.customPrimary, radius: 5)
                                    .padding()
                            }
                        }
                    }
                    .padding(.top, UIScreen.screenHeight / 15)
                }
                
                Spacer()
            }
            .alert("グループ削除", isPresented: $showAlert) {
                Button("削除", role: .destructive) { deleteGroup()}
                Button("取消", role: .cancel) {}
            } message: {
                Text("\(self.title)グループを削除します。")
            }
        }
        .toolbar(.hidden)
    }
    
    func deleteGroup() {
        var date = ""
        
        for i in photoGroup {
            if i.title == self.title {
                date = i.date!
                viewContext.delete(i)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                break
            }
        }
        
        for i in photoGroup {
            if i.date == date {
                return
            }
        }
        
        for i in photoGroupDate {
            if i.date == date {
                viewContext.delete(i)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}
