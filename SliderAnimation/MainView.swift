//
//  MainView.swift
//  SliderAnimation
//
//  Created by ELMIR ISMAYILZADA on 03.09.22.
//

import SwiftUI

struct MainView: View {
    
    @State var circlesXOffset = CGFloat.zero
    @State var rectangleWidth = CGFloat.zero
    @State var lastDragValue = CGFloat.zero
    @State var secondCircleYOffset: CGFloat = .zero
    @State var secondCircleWH: CGFloat = 30
    
    @State var circleText = 0
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray)
                .frame(width: 300, height: 10)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(.blue)
                .frame(width: rectangleWidth, height: 10)
            
            ZStack(alignment: .center) {
                Circle()
                    .fill(.blue)
                    .frame(width: 30, height: 30)
                    .shadow(color: .secondary, radius: 5, x: 0, y: 3)
                    .offset(x: circlesXOffset)
                
                Circle()
                    .fill(.white)
                    .frame(width: 20, height: 20)
                    .offset(x: circlesXOffset)
                
                ZStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: secondCircleWH, height: secondCircleWH)
                    
                    Text("\(circleText)")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .offset(x: circlesXOffset, y: secondCircleYOffset)
                .animation(.spring(), value: [secondCircleYOffset, rectangleWidth])
                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                    if value.location.x >= 1 && value.location.x <= 300 {
                        withAnimation {
                            rectangleWidth = value.location.x
                            circlesXOffset = value.location.x - 20
                            circleText = Int(value.location.x / 3)
                            circleUp()
                        }
                    }
                }).onEnded({ _ in
                    secondCircleYOffset = .zero
                    secondCircleWH = 30
                }))
            }
        }
    }
    
    func circleUp() {
        secondCircleYOffset = -50
        secondCircleWH = 45
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
