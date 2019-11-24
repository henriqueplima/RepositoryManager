//
//  Mocks.swift
//  RepositoryManagerTests
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation
@testable import RepositoryManager

struct Mocks {
    struct Repository {
        static let mock = """
{
    "items": [
        {
            "name": "gson",
            "full_name": "google/gson",
            "owner": {
                "login": "google",
                "avatar_url": "https://avatars1.githubusercontent.com/u/1342004?v=4",
                "type": "Organization"
            },
            "description": "A Java serialization",
            "stargazers_count": 16865,
            "forks_count": 3339
        },
        {
            "name": "Android-Universal-Image-Loader",
            "full_name": "nostra13/Android-Universal-Image-Loader",
            "owner": {
                "login": "nostra13",
                "avatar_url": "https://avatars1.githubusercontent.com/u/1223348?v=4",
                "type": "User"
            },
            "description": "Powerful and flexible library for loading, caching and displaying images on Android.",
            "stargazers_count": 16631,
            "forks_count": 6332
        },
        {
            "name": "HanLP",
            "full_name": "hankcs/HanLP",
            "owner": {
                "login": "hankcs",
                "avatar_url": "https://avatars0.githubusercontent.com/u/5326890?v=4",
                "type": "User"
            },
            "description": "自然语言处理 中文分词 词性标注 命名实体识别 依存句法分析 新词发现  关键词短语提取 自动摘要 文本分类聚类 拼音简繁",
            "stargazers_count": 16582,
            "forks_count": 4602
        }
    ]
}
""".data(using: .utf8)!
    }
}

struct Parse {
    static func doParse<T:Decodable>(type: T.Type) {
        
    }
}
