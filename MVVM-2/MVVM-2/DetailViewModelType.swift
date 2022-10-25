import Foundation

protocol DetailViewModelType {
    var description:String {get}
    var age:Box<String?> {get}
}
