//
//  MatchListCardView.swift
//  MatchMate
//
//  Created by Prakash on 25/09/25.
//

import SwiftUI
import Kingfisher

struct MatchListCardView: View {
    @Binding var data : User // update value to ViewModel based on user action
    var acceptedButtonAction : (() -> Void)?
    var cancelButtonAction : (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center,spacing: 16) {
            KFImage(URL(string: data.imageUrlStr))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .frame(width: 250,height: 200)
                .padding(.top)
            
            Text(data.fullName)
                .lineLimit(1)
                .font(.system(size: 28,weight: .bold))
                .foregroundStyle(Color.primary)
                .padding(.horizontal)
            
            
            Text(data.address)
                .lineLimit(1)
                .font(.system(size: 22))
                .foregroundStyle(Color.secondary)
                .padding(.horizontal)
            
            if data.matchStatus == .none {
                HStack(alignment: .center, spacing: 80) {
                    RoundedActionButton(status: .declined, iconName: "multiply.circle") {
                        data.matchStatus = .declined
                        cancelButtonAction?()
                    }
                    
                    RoundedActionButton(status: .accepted, iconName: "checkmark.circle") {
                        data.matchStatus = .accepted
                        acceptedButtonAction?()
                    }
                    
                }
                .padding(.bottom)
            }
            
            if data.matchStatus != .none {
                Text(data.matchStatus == .accepted ? "Accepted" : "Declined")
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.teal)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 5)
        )
        .padding(.horizontal,32)
        .padding(.vertical, 8)
    }
}

#Preview {
    MatchListCardView(data: .constant(User(id: "123", fullName: "prakash", address: "123 hsr layout", imageUrlStr: "")))
}
