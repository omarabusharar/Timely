//
//  TimeCell.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

struct TimeCell: View {
    @Binding var selectedSet: TimeSet?
    let set: TimeSet

    var isSelected: Bool {
        if selectedSet == nil {
            return false
        } else {
            return selectedSet! == set
        }
    }
    var body: some View {
       
            Button(action: {
                withAnimation(.bouncy, {
                    selectedSet = set
                })
            }, label: {
                HStack {
                    Label {
                        Text(set.title)
                            .fontWeight(.medium)
                    } icon: {
                        Image(systemName: set.icon)
                            .frame(minWidth: 20)
                    }
                    
                    Spacer()
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text(String(format: "%02d", set.hours))
                            .font(.title2)
                        Text("h ")
                            .foregroundStyle(.secondary)
                        Text(String(format: "%02d", set.minutes))
                            .font(.title2)
                        Text("m ")
                            .foregroundStyle(.secondary)
                        Text(String(format: "%02d", set.seconds))
                            .font(.title2)
                        Text("s")
                            .foregroundStyle(.secondary)
                    }
                    
                }
                .padding(5)
               
                
            })
            .buttonBorderShape(.roundedRectangle(radius: 36))
            
            .opacity(isSelected ? 1.0 : 0.2)
          
            .scaleEffect(isSelected ? 1.0 : 0.95)
          
        
        
      
      
    }
}

#Preview {
    TimeCell(selectedSet: .constant(nil), set: TimeSet.recess)
}
