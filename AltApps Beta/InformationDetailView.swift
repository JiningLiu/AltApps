//
//  InformationDetailView.swift
//  InformationDetailView
//
//  Created by JingJing on 8/3/21.
//

import SwiftUI

struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35, height: 35, alignment: .center)
                .font(.largeTitle)
                .foregroundColor(.mainColor)
                .padding()
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}

struct InformationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InformationDetailView()
    }
}
