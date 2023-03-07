//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 6/22/21.
//

import SwiftUI

struct LocationDetailView: View {

    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                BannerImageView(image: viewModel.location.createBannerImage())

                HStack {
                    AddressView(address: viewModel.location.address)
                    Spacer()
                }
                .padding(.horizontal)

                DescriptionView(text: viewModel.location.description)

                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))

                    HStack(spacing: 20) {
                        Button {
                            viewModel.getDirectionsToLocation()
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        }
                        .accessibilityLabel(Text("Get directions"))

                        Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                            LocationActionButton(color: .brandPrimary, imageName: "network")
                        })
                        .accessibilityRemoveTraits(.isButton)
                        .accessibilityLabel(Text("Go to website"))

                        Button {
                            viewModel.callLocation()
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                                .accessibilityLabel(Text("Call location"))
                        }

                        if let _ = CloudKitManager.shared.profileRecordID {
                            Button {
                                viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut : .checkedIn)
                                playHaptic()
                            } label: {
                                LocationActionButton(color: viewModel.isCheckedIn ? .grubRed : .brandPrimary,
                                                     imageName: viewModel.isCheckedIn ? "person.fill.xmark" : "person.fill.checkmark")
                                .accessibilityLabel(Text(viewModel.isCheckedIn ? "Check out of location" : "Check into location"))
                            }
                        }
                    }
                }
                .padding(.horizontal)

                Text("Who's Here?")
                    .bold()
                    .font(.title2)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel(Text("Who's Here? \(viewModel.checkedInProfiles.count) checked in"))
                    .accessibilityHint(Text("Bottom section is scrollable"))

                ZStack {
                    if viewModel.checkedInProfiles.isEmpty {
                        Text("Nobody's Here 😔")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding(.top, 30)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: viewModel.determineColumns(for: sizeCategory), content: {
                                ForEach(viewModel.checkedInProfiles) { profile in
                                    FirstNameAvatarView(profile: profile)
                                        .accessibilityElement(children: .ignore)
                                        .accessibilityAddTraits(.isButton)
                                        .accessibilityHint(Text("Show's \(profile.firstName) profile pop up."))
                                        .accessibilityLabel(Text("\(profile.firstName) \(profile.lastName)"))
                                        .onTapGesture {
                                            viewModel.show(profile: profile, in: sizeCategory)
                                        }
                                }
                            })
                        }
                    }

                    if viewModel.isLoading { LoadingView() }
                }

                Spacer()
            }
//            .accessibilityHidden(viewModel.isShowingProfileModal) // this was Sean's solution to `.accessibilityAddTraits(.isModal)` not working before... but it works now, so I won't use this line

            if viewModel.isShowingProfileModal {
                Color(.black)
                    .ignoresSafeArea()
                    .opacity(0.9)
//                    .transition(.opacity)
                    .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
                    .zIndex(1)
                    .accessibilityHidden(true)

                ProfileModalView(isShowingProfileModal: $viewModel.isShowingProfileModal,
                                 profile: viewModel.selectedProfile!)
                .accessibilityAddTraits(.isModal)
                .transition(.opacity.combined(with: .slide))
                .animation(.easeOut)
                .zIndex(2)
            }
        }
        .onAppear {
            viewModel.getCheckedInProfiles()
            viewModel.getCheckedInStatus()
        }
        .sheet(isPresented: $viewModel.isShowingProfileSheet) {
            NavigationView {
                ProfileSheetView(profile: viewModel.selectedProfile!)
                    .toolbar { Button("Dismiss", action: { viewModel.isShowingProfileSheet = false }) }
            }
            .accentColor(.brandPrimary)
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.chipotle)))
        }
        .preferredColorScheme(.dark)
        .environment(\.sizeCategory, .extraExtraLarge)

        NavigationView {
            LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.chipotle))).embedInScrollView()
        }
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}

struct LocationActionButton: View {

    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
        }
    }
}

struct FirstNameAvatarView: View {

    @Environment(\.sizeCategory) var sizeCategory
    var profile: DDGProfile

    var body: some View {
        VStack {
            AvatarView(image: profile.createAvatarImage(),
                       size: sizeCategory >= .accessibilityMedium ? 100 : 64)
            
            Text(profile.firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
            .accessibilityHidden(true)
    }
}

struct AddressView: View {
    var address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct DescriptionView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .minimumScaleFactor(0.75)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
    }
}
