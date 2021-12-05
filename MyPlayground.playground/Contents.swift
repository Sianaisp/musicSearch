import UIKit

let json = """
{
    "data": [{
        "id": 399,
        "name": "Radiohead",
        "picture_big": "lalala"
    }, {
        "id": 14009761,
        "name": "Radiohead Tribute Band"
        "picture_big": "lololo"
    }, {
        "id": 53477202,
        "name": "DJ Radiohead",
        "picture_big": "bababa"
    }],
    "total": 3
}

"""
struct APIResponse: Codable {
    let data: [Artist]?
    let total: Int
}

struct Artist: Codable {
    let name: String
    let picture: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case picture = "picture_big"
        case id
    }
}
let urlString =  "http://api.deezer.com/search/artist?q=radiohead"
let url = URL(string: urlString)
let request = NSMutableURLRequest(url: NSURL(string: "http://api.deezer.com/search/artist?q=radiohead")! as URL)
let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
    guard let data = data, error == nil else { return }
    let decoder = JSONDecoder()
    do {
        let result = try decoder.decode(APIResponse.self, from: data)
        print("This is JSON result--> \n\(result)")
    }
    catch {
        print("Failed to decode with error: (error)")
    }
})
dataTask.resume()

