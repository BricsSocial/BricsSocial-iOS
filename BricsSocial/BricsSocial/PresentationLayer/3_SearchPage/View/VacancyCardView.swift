//
//  VacancyCardView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import SwiftUI

struct VacancyCardView: View {
    
    var vacancy: Vacancy
    var company: Company?
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        if company?.logo != nil {
                            AsyncImage(
                                url: URL(string: company?.logo ?? "")) { phase in
                                    if case .success(let image) = phase {
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                .clipShape(Circle())
                                .frame(maxWidth: 50, maxHeight: 50)
                        }
                        
                        Text(company?.name ?? "")
                            .foregroundColor(.white)
                            .font(.title.bold())
                            .frame(height: 50, alignment: .center)
                    }
                    Divider()
                        .background(Color.white)
                    
                    Text(vacancy.name ?? "")
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .font(.title.bold())
                        .frame(height: 50, alignment: .center)
                    Text("Offerings:")
                        .foregroundColor(.white)
                        .font(.headline.bold())
                        .padding(.vertical, 2)
                    Text(vacancy.offerings ?? "")
                        .foregroundColor(.gray)
                        .font(.callout)
                        .lineLimit(3)
                        .padding(.bottom, 15)
                    Text("Requirements:")
                        .foregroundColor(.white)
                        .font(.headline.bold())
                        .padding(.vertical, 2)
                    Text(vacancy.requirements ?? "")
                        .foregroundColor(.gray)
                        .font(.callout)
                        .lineLimit(3)
                    Spacer()
                    if !(vacancy.skillTags?.isEmpty ?? true) {
                        HStack(alignment: .center) {
                            ForEach(vacancy.skills.prefix(3)) { value in
                                Text(value.name)
                                    .font(.callout.bold())
                                    .foregroundColor(.white)
                                    .frame(minWidth: 20)
                                    .padding(.all, 10)
                                    .background(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                        
                    }
                }
                Spacer()
            }
            .padding()
            .frame(width: proxy.size.width, height: proxy.size.height)
            .background(
                Image("CardBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color(.black)
                        .cornerRadius(13)
                        .opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
    }
}

struct CompanyCardView_Previews: PreviewProvider {
    static var previews: some View {
        VacancyCardView(vacancy: .init(id: 1,
                                       name: "Tinkoff",
                                       requirements: "Looking up to something new",
                                       offerings: "10k/month",
                                       status: .open,
                                       skillTags: "C++, C, Swift",
                                       companyId: 1), company: .init(id: 1, name: "Tinkoff", description: "IT Fintech", logo: ""))
    }
}
