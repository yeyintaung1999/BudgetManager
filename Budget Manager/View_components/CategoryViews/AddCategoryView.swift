//
//  AddCategoryView.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 16/01/2023.
//

import SwiftUI

struct AddCategoryView: View {
    
    var type : RecordType
    var model = CategoryModel.shared
    
   
    
    @Binding var isPresented: Bool
    @State var name : String = ""
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                VStack{
                    Text("Enter Category Name")
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
                        .foregroundColor(.secondary)
                    TextField("eg. Salary", text: $name)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(.secondary))
                        .onSubmit {
                            didEndEditing()
                        }
                }
                
                Button(action: {
                    
                    didEndEditing()
                }, label: {
                    Text("Add")
                })
                .foregroundColor(Color(uiColor: UIColor(named: "LightColor")!))
                .padding([.leading, .trailing], 30)
                .padding([.top, .bottom], 10)
                .background(RoundedCorners(color: Color(uiColor: UIColor(named: "ThemeColor")!), tl: 5, tr: 5, bl: 5, br: 5))
                
                
            }.padding(20)
            
                .navigationTitle("Add New Category")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    
                    isPresented = false
                }, label: {
                    Text("Cancel")
                }))
        }
    }
    
    func didEndEditing(){
        model.addCategory(name: name, type: type)
        isPresented = false
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(type: .income, isPresented: .constant(true))
    }
}



