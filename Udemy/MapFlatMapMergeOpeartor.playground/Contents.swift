import UIKit
import Combine

let publisher = (1...10).publisher
let mapPublisher = publisher.map{$0*2}
var cancellable = mapPublisher.sink { data in
    print (data)
}


//Flat map will work for string namePublisher only & won't work for Int publisher
let namePublisher = ["Ram", "Shyam"].publisher

let flatMapPublisher = namePublisher.flatMap { value in
    return value.publisher
}
cancellable = flatMapPublisher.sink { data in
    print (data)
}

//Merge publisher

let merge1 = (1...3).publisher
let merge2 = (4...6).publisher
let merge = Publishers.Merge(merge1, merge2) // merge1.merge(with: merge2)
cancellable = merge.sink{value in
    print("Hello",value)
}

