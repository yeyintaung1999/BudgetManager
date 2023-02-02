//
//  RemoveCategoryView.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 17/01/2023.
//

import SwiftUI

struct RemoveCategoryView: View {
    
    var categoryList: FetchedResults<CategoryEntity>?
    
    let categoryModel = CategoryModel.shared
    let recordModel = RecordModel.shared
    
    @State var indexSet = IndexSet()
    
    @State var isShowingAlert: Bool = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(categoryList!, id: \.name) { item in
                    HStack{
                        Text(item.name ?? "")
                        Spacer()
                        Button {
                            isShowingAlert=true
                        } label: {
                            Image(systemName: "delete.left").foregroundColor(.red)
                        }

                    }
                }.onDelete { indexset in
                    indexSet = indexset
                    isShowingAlert = true
                }
            }
        }
        .alert("Related Records will also be Removed! Confirm to Remove!", isPresented: $isShowingAlert) {
            Button {
                removeFunc(indexset: indexSet)
                isShowingAlert = false
            } label: {
                Text("Remove")
            }
            Button {
                isShowingAlert = false
            } label: {
                Text("Cancel")
            }


        }
    }
    
    func removeFunc(indexset: IndexSet){
        let records = categoryList![indexset.first ?? 99].records as? Set<RecordEntity>
        
        records?.forEach({ record in
            recordModel.removeRecord(record: record)
        })
        
        categoryModel.removeCategory(category: categoryList![indexset.first ?? 99])
    }
}

struct RemoveCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        RemoveCategoryView()
    }
}
