//
//  ReplyCardView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import SwiftUI

struct ReplyCardView: View {
    
    var reply: Reply
    var company: Company?
    
    var body: some View {
        card
    }
    
    private var card: some View {
        VStack(alignment: .leading) {
            HStack {
                if let logo = company?.logo {
                    AsyncImage(url: URL(string: logo)) {
                        phase in
                            if case .success(let image) = phase {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                    }
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay(Circle().stroke().fill(Color.black))
                }
                Text(company?.name ?? "Unknown company")
                    .font(.callout.bold())
                    .foregroundColor(.black)
                    .padding(.vertical)
                Spacer()
                status
            }
            .padding(.leading)
            .padding(.bottom, -10)
            Divider()
            Text(reply.vacancy.name ?? "Unknown")
                .font(.title2.bold())
                .padding(.bottom, 3)
            .padding(.horizontal)
            Text("Offerings: " + (reply.vacancy.offerings ?? ""))
                .lineLimit(2)
                .foregroundColor(.gray)
                .font(.caption)
                .padding(.horizontal)
                .padding(.bottom, 20)
            approve
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 4)
        )
        .padding()
    }
    
    private var status: some View {
        HStack {
            Circle()
                .fill(reply.status.color)
                .frame(width: 10, height: 10)
            Text(reply.status.raw.capitalized)
                .font(.callout.bold())
                .foregroundColor(reply.status.color)
        }
        .padding()
    }
    
    private var approve: some View {
        HStack {
            Button {
                
            } label: {
                Text("Approve")
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
            }
            
            Button {
                
            } label: {
                Text("Decline")
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
            }
        }
        .padding(.top, -10)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct ReplyCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReplyCardView(reply: .init(vacancy: .init(id: 1,
                                                  name: "Developer",
                                                  requirements: "", offerings: "Offering new office, cool team and hype",
                                                  status: .open, skillTags: "",
                                                  companyId: 2),
                                   status: .pending,
                                   type: .specialist),
    company: Company(id: 1, name: "Sber",
                     description: "Sber", logo: "https://s3.yandexcloud.net/brics-server-dev/companies/0e6ab87a-d8a4-4451-ba80-32ba4857ddbd.jpg"))
    }
}
