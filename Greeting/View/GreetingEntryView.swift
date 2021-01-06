//
//  GreetingEntryView.swift
//  GreetingWidget
//
//  Created by mac-00021 on 30/09/20.
//

import WidgetKit
import SwiftUI
import struct Kingfisher.KFImage
import URLImage

struct GreetingEntryView: View {
    var entry: GreetingTimeline.Entry
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            URLImage(url: entry.url,
                     options: URLImageOptions(
                        cachePolicy: .returnCacheDontLoad()),
                     
                     inProgress: { progress -> Text in
                        return Text("Loading...")
                            .foregroundColor(.black)
                     },
                     failure: { error, retry in
                        VStack {
                            Text(error.localizedDescription)
                            Button("Retry", action: retry)
                        }
                     },
                     content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                     })
                .clearImageCache()
            VStack {
                Text(Date(), style: .time)
                Spacer()
            }
            .padding(18)
            
            VStack {
                Spacer()
                Text(greeting())
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(18)
            
        }
        .font(.headline)
        .foregroundColor(.white)
    }
    
    /// Get greeting as per current time
    
    func greeting() -> String {
        
        var greet = ""
        
        let midNight0 = Calendar.current.date(bySettingHour: 0, minute: 00, second: 00, of: entry.date)!
        let nightEnd = Calendar.current.date(bySettingHour: 3, minute: 59, second: 59, of: entry.date)!
        
        let morningStart = Calendar.current.date(bySettingHour: 4, minute: 00, second: 0, of: entry.date)!
        let morningEnd = Calendar.current.date(bySettingHour: 11, minute: 59, second: 59, of: entry.date)!
        
        let noonStart = Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: entry.date)!
        let noonEnd = Calendar.current.date(bySettingHour: 16, minute: 59, second: 59, of: entry.date)!
        
        let eveStart = Calendar.current.date(bySettingHour: 17, minute: 00, second: 00, of: entry.date)!
        let eveEnd = Calendar.current.date(bySettingHour: 20, minute: 59, second: 59, of: entry.date)!
        
        let nightStart = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: entry.date)!
        let midNight24 = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: entry.date)!
        
        if ((entry.date >= midNight0) && (nightEnd >= entry.date)) {
            greet = "Good Night 🌙"
        } else if ((entry.date >= morningStart) && (morningEnd >= entry.date)) {
            greet = "Good Morning 🌤"
        } else if ((entry.date >= noonStart) && (noonEnd >= entry.date)) {
            greet = "Good Afternoon ☀️"
        } else if ((entry.date >= eveStart) && (eveEnd >= entry.date)) {
            greet = "Good Evening 🌥"
        } else if ((entry.date >= nightStart) && (midNight24 >= entry.date)) {
            greet = "Good Night 🌙"
        }
        
        /// Set name of device with greeting
        
        return "Hi \(UIDevice.current.name),\n\(greet)"
    }
}

struct GreetingEntryView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingEntryView(entry: GreetingEntryModel(date: Date()))
    }
}

extension View {
    func clearImageCache() -> Self {
        URLImageService.shared.removeAllCachedImages()
        return self
    }
}
