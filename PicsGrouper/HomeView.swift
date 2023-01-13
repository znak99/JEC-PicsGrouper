//
//  ContentView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: PhotoGroup.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoGroup.date, ascending: true)])
    var photoGroup: FetchedResults<PhotoGroup>
    
    @FetchRequest(
        entity: PhotoGroupDate.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoGroupDate.date, ascending: true)])
    var photoGroupDate: FetchedResults<PhotoGroupDate>

    var body: some View {
        NavigationView {
            ZStack {
                Color.customWhite.ignoresSafeArea()
                
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
