//
//  ToastView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 12/27/22.
//

import SwiftUI

enum ToastStyle {
    case error, success, info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .success: return Color.green
        case .info: return Color.blue
        }
    }

    var iconFileName: String {
        switch self {
        case .error: return "xmark.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
}

struct ToastView: View {
    var type: ToastStyle
    var title: String
    var message: String
    var onCancelTapped: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: type.iconFileName)
                    .foregroundColor(type.themeColor)

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))

                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }

                Spacer(minLength: 10)

                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
            }
            .padding()
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(type: .success, title: "Success", message: "You did it!") {}
    }
}
