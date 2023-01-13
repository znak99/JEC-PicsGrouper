//
//  ContentView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @State var buttonAnimAmount: CGFloat = 1
    
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
        NavigationView {
            ZStack {
                Color.customWhite.ignoresSafeArea()
                VStack {
                    PageTitleView(title: "リスト")
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(photoGroupDate, id: \.self) { date in
                                VStack {
                                    HStack {
                                        Text(date.date ?? "")
                                            .foregroundColor(Color.customBlack)
                                            .font(.custom(notosansBold, size: UIScreen.screenWidth / 24))
                                        Spacer()
                                    }
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(photoGroup, id: \.self) { group in
                                                if group.date == date.date {
                                                    NavigationLink(destination: DetailView()) {
                                                        ZStack {
                                                            if group.pictures.count > 2 {
                                                                Image(uiImage: UIImage(data: group.pictures[2])!)
                                                                    .resizable()
                                                                    .frame(width: UIScreen.screenWidth / 5, height: UIScreen.screenWidth / 5)
                                                                    .shadow(color: Color.customPrimary, radius: 1)
                                                                    .rotationEffect(.degrees(-16))
                                                                Image(uiImage: UIImage(data: group.pictures[1])!)
                                                                    .resizable()
                                                                    .frame(width: UIScreen.screenWidth / 5, height: UIScreen.screenWidth / 5)
                                                                    .shadow(color: Color.customPrimary, radius: 2)
                                                                    .rotationEffect(.degrees(8))
                                                                Image(uiImage: UIImage(data: group.pictures[0])!)
                                                                    .resizable()
                                                                    .frame(width: UIScreen.screenWidth / 5, height: UIScreen.screenWidth / 5)
                                                                    .shadow(color: Color.customPrimary, radius: 3)
                                                                    .rotationEffect(.degrees(-4))
                                                            } else if group.pictures.count > 1 {
                                                                Image(uiImage: UIImage(data: group.pictures[1])!)
                                                                    .resizable()
                                                                    .frame(width: UIScreen.screenWidth / 5, height: UIScreen.screenWidth / 5)
                                                                    .shadow(color: Color.customPrimary, radius: 2)
                                                                    .rotationEffect(.degrees(4))
                                                                Image(uiImage: UIImage(data: group.pictures[0])!)
                                                                    .resizable()
                                                                    .frame(width: UIScreen.screenWidth / 5, height: UIScreen.screenWidth / 5)
                                                                    .shadow(color: Color.customPrimary, radius: 3)
                                                                    .rotationEffect(.degrees(-4))
                                                            } else {
                                                                Image(uiImage: UIImage(data: group.pictures[0])!)
                                                                    .resizable()
                                                                    .frame(width: UIScreen.screenWidth / 5, height: UIScreen.screenWidth / 5)
                                                                    .shadow(color: Color.customPrimary, radius: 3)
                                                                    .rotationEffect(.degrees(4))
                                                            }
                                                            Text(group.title ?? "")
                                                                .font(.custom(notosansMedium, size: UIScreen.screenWidth / 32))
                                                                .foregroundColor(.white)
                                                                .padding(.vertical, UIScreen.screenWidth / 120)
                                                                .padding(.horizontal, UIScreen.screenWidth / 30)
                                                                .background(Color.customPrimary)
                                                                .cornerRadius(6)
                                                                .offset(y: UIScreen.screenHeight / 22.5)
                                                            Text(dateToStr(update: group.update))
                                                                .font(.custom(notosansMedium, size: UIScreen.screenWidth / 48))
                                                                .foregroundColor(Color.customBlack.opacity(0.5))
                                                                .offset(x: 5, y: UIScreen.screenHeight / 22.5 + 25)
                                                        }
                                                        .padding()
                                                    }
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                                    .background(.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.customBlack.opacity(0.2), radius: 5)
                                }
                                .padding()
                            }
                        }
                        .padding(.bottom, UIScreen.screenHeight / 12)
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    NavigationLink(destination: CreateView()) {
                        HStack {
                            Spacer()
                            Text("グループ作成")
                                .font(.custom(notosansBold, size: UIScreen.screenWidth / 20))
                                .foregroundColor(Color.customWhite)
                                .padding()
                            Spacer()
                        }
                        .background(Color.customPrimary)
                        .cornerRadius(15)
                        .shadow(color: Color.customBlack.opacity(0.5), radius: 4)
                        .padding()
                    }
                }
            }
            .toolbar(.hidden)
        }
    }
    
    func dateToStr(update: Date?) -> String {
        guard let update = update else { return "Date Error" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd作成"
        return formatter.string(from: update)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
