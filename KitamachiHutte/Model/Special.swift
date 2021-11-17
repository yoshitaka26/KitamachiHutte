import SwiftUI

// 特別メニュー
struct Special : Hashable, Codable, Identifiable {
    public var id: String                        // ID
    public var imageName: String                 // 画像リソース名
    public var caption: String                   // キャプション
    public var text: String                      // サブテキスト
    public var image: Image { Image(imageName) } // 画像
    public var category: Category                // カテゴリ
    public var isFeatured: Bool                  // おすすめ
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case new = "本日のおすすめ"            // 新商品
        case sale = "旬の食材"          // 割引販売
        case featured = "日本酒に合う"  // おすすめ
    }
}
