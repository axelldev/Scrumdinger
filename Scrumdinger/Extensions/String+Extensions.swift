//
//  String+Extensions.swift
//  Scrumdinger
//
//  Created by axell solis on 05/09/25.
//
import Foundation

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
