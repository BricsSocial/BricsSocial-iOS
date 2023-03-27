//
//  StackCardView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 22.03.2023.
//

import SwiftUI

struct StackCardView: View {
    
    @EnvironmentObject var viewModel: SearchPageViewModel
    var vacancy: Vacancy
    
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    
    @State var endSwipe: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let size  = proxy.size
            let index = CGFloat(viewModel.getIndex(vacancy: vacancy))
            let topOffset = (index <= 2 ? index : 2) * 15
            
            ZStack {
                VacancyCardView(vacancy: vacancy, company: viewModel.getCompany(vacancy: vacancy))
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(15)
                    .offset(y: -topOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging) { vlaue, out, _ in
                    out = true
                }
                .onChanged { value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                }
                .onEnded { value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeActions()
                            
                            if translation > 0 {
                                rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                }
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            guard let info = data.userInfo,
                  let id = info["id"] as? Int,
                  let rightSwipe = info["rightSwipe"] as? Bool
            else { return }
            
            let width = getRect().width - 50
            
            if vacancy.id == id {
                withAnimation {
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    
                    if rightSwipe {
                        self.rightSwipe()
                    } else {
                        leftSwipe()
                    }
                }
            }
        }
    }
    
    func leftSwipe() {
        print("Left Swipe")
    }
    
    func rightSwipe() {
        print("Right Swipe")
    }
    
    
    func getRotation(angle: Double) -> Double {
        let rotation = (offset / (getRect().width - 50)) * angle
        return rotation
    }
    
    func endSwipeActions() {
        withAnimation(.none) { endSwipe = true }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let _ = viewModel.displayingVacancies.first {
                let _ = withAnimation {
                    viewModel.displayingVacancies.removeFirst()
                }
            }
        }
    }
}

extension View {
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
