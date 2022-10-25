import Foundation

class DetailViewModel:DetailViewModelType {
    
    private var profile: Profile
    
    var description: String {
        return String(describing: "\(profile.name)\(profile.secondName)is \(profile.age) old!")
        
    }
    var age: Box<String?> = Box(nil)
    init(profile:Profile) {
        self.profile = profile
    }
}
