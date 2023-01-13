//
//  CreateView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI

struct CreateView: View {
    
    @State var selected: [UIImage] = []
    @State var show = false
    @State var showEmptyFieldWarnning = false
    
    @State var title = ""
    @State var year: Int = 2023
    @State var month: Int = 1
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(
        entity: PhotoGroupDate.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoGroupDate.date, ascending: false)])
    var photoGroupDate: FetchedResults<PhotoGroupDate>
    
    var body: some View {
        ZStack {
            Color.customWhite.ignoresSafeArea()
            VStack {
                PageTitleView(title: "グループ作成")
                Button(action: { dismiss() }) {
                    HStack {
                        Spacer()
                        Text("ホームに戻る")
                            .foregroundColor(Color.customRed)
                            .font(.custom(notosansMedium, size: UIScreen.screenWidth / 32))
                            .underline(true)
                    }
                }
                .padding(.trailing)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        if !self.selected.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(self.selected, id: \.self) { i in
                                        Image(uiImage: i)
                                            .resizable()
                                            .frame(width: UIScreen.screenWidth - 40, height: 250)
                                            .cornerRadius(15)
                                            .shadow(color: Color.customPrimary, radius: 5, y: 2)
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        Button(action: {
                            self.selected.removeAll()
                            self.show.toggle()
                        }) {
                            HStack(spacing: 0) {
                                Text(self.selected.isEmpty ? "写真追加 " : "写真編集")
                                    .font(.custom(self.selected.isEmpty ? notosansBold :
                                        notosansMedium,
                                        size: self.selected.isEmpty ?
                                        UIScreen.screenWidth / 20 :
                                        UIScreen.screenWidth / 28))
                                Image(systemName: self.selected.isEmpty ? "plus" : "square.and.pencil")
                                    .fontWeight(self.selected.isEmpty ? .bold : .medium)
                                    .font(.system(size: self.selected.isEmpty ?
                                                  UIScreen.screenWidth / 20 :
                                                  UIScreen.screenWidth / 28))
                            }
                            .padding()
                            .background(Color.customPrimary)
                            .foregroundColor(Color.customWhite)
                            .cornerRadius(UIScreen.screenWidth / 24)
                        }
                        .shadow(color: Color.customBlack.opacity(0.8), radius: 3, x: 0, y: 1)
                        
                        if !self.selected.isEmpty {
                            VStack {
                                HStack {
                                    Text("タイトル")
                                        .font(.custom(notosansBold, size: UIScreen.screenWidth / 24))
                                        .foregroundColor(Color.customBlack)
                                    Spacer()
                                }
                                TextField("8文字以内入力", text: $title)
                                    .font(.custom(notosansMedium, size: UIScreen.screenWidth / 24))
                                    .foregroundColor(Color.customBlack)
                                    .padding(.horizontal)
                            }
                            .padding()
                            VStack {
                                HStack {
                                    Text("年")
                                        .font(.custom(notosansBold, size: UIScreen.screenWidth / 24))
                                        .foregroundColor(Color.customBlack)
                                    Spacer()
                                    Text("月")
                                        .font(.custom(notosansBold, size: UIScreen.screenWidth / 24))
                                        .foregroundColor(Color.customBlack)
                                    Spacer()
                                }
                                HStack {
                                    Picker("年度を選択", selection: $year) {
                                        ForEach(1990..<2040) { year in
                                            Text("\(String(year))年")
                                                .tag(year)
                                                .font(.custom(notosansMedium, size: UIScreen.screenWidth / 24))
                                                .foregroundColor(Color.customBlack)
                                        }
                                    }
                                    Spacer()
                                    Picker("月を選択", selection: $month) {
                                        ForEach(1..<13) { month in
                                            Text("\(String(month))月")
                                                .tag(month)
                                                .font(.custom(notosansMedium, size: UIScreen.screenWidth / 24))
                                                .foregroundColor(Color.customBlack)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .padding([.horizontal, .top])
                            
                            Button(action: {
                                if title.isEmpty {
                                    self.showEmptyFieldWarnning.toggle()
                                } else {
                                    saveGroup()
                                }
                            }) {
                                HStack {
                                    Spacer()
                                    Text("グループ作成")
                                        .font(.custom(notosansBold, size: UIScreen.screenWidth / 20))
                                        .foregroundColor(Color.customWhite)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.customPrimary)
                                .cornerRadius(15)
                                .padding([.horizontal, .top])
                                .shadow(color: Color.customBlack.opacity(0.5), radius: 4)
                            }
                        }
                    }
                }
                Spacer()
            }
                .alert("グループ作成失敗", isPresented: $showEmptyFieldWarnning) {
                    Button("Ok") {}
                } message: {
                    Text("タイトルを入力してください")
                }
            if self.show {
                CustomPickerView(selected: self.$selected, show: self.$show)
            }
        }
        .toolbar(.hidden)
    }
    
    func saveGroup() {
        let dateContext = "\(self.year)/\(self.month)"
        withAnimation {
            
            if !checkDate(dateContext: dateContext) {
                let groupDate = PhotoGroupDate(context: viewContext)
                groupDate.date = dateContext
            }
            
            let group = PhotoGroup(context: viewContext)
            group.title = self.title
            group.update = Date()
            group.pictures = self.selected.map({ image in
                image.pngData()!
            })
            group.date = dateContext
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            
        }
        dismiss()
    }
    
    func checkDate(dateContext: String) -> Bool {
        
        for i in photoGroupDate {
            if i.date == dateContext {
                return true
            }
        }
        
        return false
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
