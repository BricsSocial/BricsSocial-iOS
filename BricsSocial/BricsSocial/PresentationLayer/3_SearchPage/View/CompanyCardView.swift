//
//  CompanyCardView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import SwiftUI

struct CompanyCardView: View {
    var company: Company
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        AsyncImage(
                            url: URL(string: "https://s3-symbol-logo.tradingview.com/tcs-group-holding--600.png")) { phase in
                                if case .success(let image) = phase {
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                
                            }
                            .clipShape(Circle())
                            .frame(maxWidth: 50, maxHeight: 50)
                        
                        Text(company.name)
                            .foregroundColor(.white)
                            .font(.title.bold())
                            .frame(height: 50, alignment: .center)
                    }
                    Divider()
                        .background(Color.white)
                    Text(company.description)
                        .foregroundColor(.white)
                        .font(.callout.bold())
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .frame(width: proxy.size.width, height: proxy.size.height)
            .background(
                AsyncImage(url: URL(string: company.logo))
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color(.black)
                        .cornerRadius(13)
                        .opacity(0.7))
            )
        }
    }
}

struct CompanyCardView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCardView(company: .init(id: 1,
                                       name: "Tinkoff",
                                       description: "The Tinkoff financial ecosystem offers a full range of financial and lifestyle services for individuals and businesses via its mobile app and web interface. At the core of the ecosystem is Tinkoff Bank, one of the world’s biggest online banks with over 20 million customers.",
                                       logo: "https://telekomdom.com/wp-content/uploads/2022/08/tinkoff-id--1024x572.png",
                                       countryId: 1))
    }
}
