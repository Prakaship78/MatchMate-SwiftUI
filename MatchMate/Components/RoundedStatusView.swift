//
//  RoundedStatusView.swift
//  MatchMate
//
//  Created by Prakash on 26/09/25.
//

import SwiftUI

struct RoundedStatusView : View {
    let status : String
    var body: some View {
        Text(status)
            .font(.system(size: 24))
            .frame(maxWidth: .infinity)
            .frame(height: 50)
//            .background(Color.teal)
//            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .glassEffect(in : .rect(cornerRadius: 12))
    }
}
