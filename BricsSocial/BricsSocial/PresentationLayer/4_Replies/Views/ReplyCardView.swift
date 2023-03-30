//
//  ReplyCardView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import SwiftUI

struct ReplyCardView: View {
    
    @ObservedObject var viewModel: ReplyCardViewModel
    
    var body: some View {
        card
            .disabled(viewModel.reply.vacancy.status == .closed)
            .opacity((viewModel.reply.vacancy.status == .closed) ? 0.4 : 1)
    }
    
    private var isApproved: Bool {
        viewModel.reply.status == .approved
    }
    
    private var isDeclined: Bool {
        viewModel.reply.status == .rejected
    }
    
    private var card: some View {
        VStack(alignment: .leading) {
            HStack {
                if let logo = viewModel.company?.logo {
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
                Text(viewModel.company?.name ?? "Unknown company")
                    .font(.callout.bold())
                    .foregroundColor(.black)
                    .padding(.vertical)
                Spacer()
                status
            }
            .padding(.leading)
            .padding(.bottom, -10)
            Divider()
            Text(viewModel.reply.vacancy.name ?? "Unknown")
                .font(.title3.bold())
            .padding(.horizontal)
            .padding(.bottom, 2)
            
            Text("Offerings: \(viewModel.reply.vacancy.offerings ??  "No offerings provided")")
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(Color.gray)
                .padding(.horizontal)
                .padding(.bottom, 15)
            
            if viewModel.reply.type == .specialist {
                approve
            }
            
            if viewModel.reply.status == .approved {
                agentInfo
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 4)
        )
        .animation(.easeInOut)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    private var agentInfo: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack(alignment: .top, spacing: 5) {
                if let logo = viewModel.reply.agent?.photo {
                    AsyncImage(url: URL(string: logo)) {
                        phase in
                        if case .success(let image) = phase {
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .overlay(Circle().stroke().fill(Color.black))
                }
                VStack(alignment: .leading) {
                    Text(viewModel.reply.agent?.position ?? "Agent")
                        .foregroundColor(.black)
                        .font(.caption.bold())
                    Text("\(viewModel.reply.agent?.firstName ?? "Name") \(viewModel.reply.agent?.lastName ?? "Last Name")")
                        .foregroundColor(.black)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .foregroundColor(.black)
                        .font(.caption.bold())
                    Text("\(viewModel.reply.agent?.email ?? "company@gmail.com")")
                        .lineLimit(1)
                        .foregroundColor(.black)
                        .font(.caption)
                }.frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color("LightGrayColor"))
    }
    
    private var status: some View {
        HStack {
            Circle()
                .fill(viewModel.reply.status.color)
                .frame(width: 10, height: 10)
            Text(viewModel.reply.status.raw.capitalized)
                .font(.callout.bold())
                .foregroundColor(viewModel.reply.status.color)
        }
        .padding()
    }
    
    private var approve: some View {
        HStack {
            Button {
                Task {
                    await viewModel.acceptReply()
                }
            } label: {
                Text(isApproved ? "Approved" : "Approve")
                    .foregroundColor(.white)
                    .font(.caption2)
                    .bold()
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
            }
            .disabled(isApproved)
            
            Button {
                Task {
                    await viewModel.rejectReply()
                }
            } label: {
                Text(isDeclined ? "Declined" : "Decline")
                    .foregroundColor(.white)
                    .font(.caption2)
                    .bold()
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
            }
            .disabled(isDeclined)
            
        }
        .padding(.top, -10)
        .padding(.horizontal)
        .padding(.bottom, 15)
    }
}
