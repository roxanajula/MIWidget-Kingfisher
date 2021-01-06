//
//  GreetingEntryModel.swift
//  GreetingWidget
//
//  Created by mac-00021 on 30/09/20.
//

import WidgetKit
import SwiftUI

struct GreetingEntryModel: TimelineEntry {
    let date: Date
    let url = URL(string: "https://picsum.photos/1080/620")!
}
