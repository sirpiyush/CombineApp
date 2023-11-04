//
//  StringExtension.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 04/11/23.
//

import Foundation

extension String{
    func encodedString()->String?{
        let text = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
