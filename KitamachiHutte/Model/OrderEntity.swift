import Foundation

enum Hour:Int16 {
    case milk_tea
    case uji_matcha_milk
    case okinawa_brown_sugar_milk
    case cassis_raspberry_milk
    case strawberry_milk
    
    var name: String {
        hourArray[Int(self.rawValue)]
    }
}

enum Menu:Int16 {
    case None
    case Vanilla
    case Tea
    case Matcha
    
    var name: String {
        menuArray[Int(self.rawValue)]
    }
}

var hourArray = ["18:00",
                   "18:30",
                   "19:00",
                   "19:30",
                   "20:00"]
var menuArray = ["座席のみ",
                     "季節のコース",
                     "特上コース",
                     "おまかせ"]


class OrderEntity : Identifiable, ObservableObject {
    @Published public var id: String       // ID
    @Published public var date: Date    // 予約日
    @Published public var hour: Int16  // 予約時間
    @Published public var number: Int16 // 予約人数
    @Published public var menu: Int16    // 予約内容
    @Published public var other: String       // 要望
    @Published public var name: String  // 予約者名

    /// 予約時間の文字列を取得する
    public var hourDetail: String {
        Hour(rawValue: self.hour)!.name
    }
    
    /// 予約内容の文字列を取得する
    public var menuDetail: String {
        Menu(rawValue: self.menu)!.name
    }
    
    public var dateForShow: String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: self.date)
    }
    
    init(id: String = UUID().uuidString, date: Date = Date(), hour: Int = 0, number: Int = 1, menu: Int = 0, other: String = "", name: String = "ゲスト") {
        self.id = id
        self.date = date
        self.hour = Int16(hour)
        self.number = Int16(number)
        self.menu = Int16(menu)
        self.other = other
        self.name = name
    }
    
}
