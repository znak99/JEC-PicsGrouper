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
                                if date != nil {
                                    VStack {
                                        HStack {
                                            Text(date.date ?? "")
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
