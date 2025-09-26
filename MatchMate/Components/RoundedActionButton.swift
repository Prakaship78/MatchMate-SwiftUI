//
//  RoundedActionButton.swift
//  MatchMate
//
//  Created by Prakash on 26/09/25.
//

import SwiftUI

struct RoundedActionButton : View {
    let status : MatchStatus
    let iconName : String
    let action : (()->Void)?
    var body: some View {
        Button {
            action?()
//            data.matchStatus = .declined
//            cancelButtonAction?()
        } label: {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 50,height: 50)
                .foregroundStyle(Color.red)
        }
    }
}
