//
//  URLSession-Decodable.swift
//  Ashcott
//
//  Created by Nigel Gee on 21/05/2026.
//

import Foundation

extension URLSession {
    /// A URLSession extension that fetches data from a URL and decodes to some Decodable type.
    /// - Parameters:
    ///   - type: The model (T) to decode.
    ///   - urlString: The string of the url to get data.
    ///   - keyDecodingStrategy: Any custom Key Code - default: `.useDefaultKeys`.
    ///   - dataDecodingStrategy: Any data format - default: `.deferredToData` but can use `.snakeToCamel`.
    ///   - dateDecodingStrategy: Any date format - default: `.deferredToDate` but can use `.iso1801`.
    /// ```swift
    ///   struct ContentView: View {
    ///     @State private var myModels = [MyModel]()
    ///
    ///     var body some View {
    ///         List(myModels) { myModel in
    ///             Text(myModel.name)
    ///         }
    ///         .task { await fetch() }
    ///     }
    ///
    ///     func fetch() async {
    ///         do {
    ///             async let items = try await URLSession.shared.decode([MyModel].self, from "SomeSite")
    ///             myModels = try await items
    ///         } catch {
    ///             print("Failed to fetch data!")
    ///         }
    ///     }
    /// ```
    /// - Returns: The type decoded.
    /// - Important: Type (`T`) must conform to `Decodable`
    /// - Authors: Paul Hudson
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from urlString: String,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        guard let url = URL(string: urlString) else {
            fatalError("Unable to get URL")
        }

        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}

enum Base: String {
    case url = "https://nigelgee.github.io/beerFestResources/"
}
