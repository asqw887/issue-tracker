# IssueTracker 

- Github 와 연동하여 Issue를 관리할 수 있는 앱 
- 개발 기간 : 2022.06.13 ~  2022.07.01 
- 팀원
    * Jazz의 신 [체즈](https://github.com/asqw887)
    * 구찌갱 [구찌](https://github.com/Damagucci-Juice)
---

# 데모  


| 로그인 화면 | 이슈 목록 화면 | 깃허브 모바일 웹 로그인 화면 | 이슈 선택 화면|
| -------- | -------- | -------- | -------- |
| ![](https://i.imgur.com/Qa0rdNs.png)| ![](https://i.imgur.com/VUtoEBf.png)| ![](https://i.imgur.com/YzLkDjM.png)| ![](https://i.imgur.com/9EvZc2p.png)|

# 기능

## 흐름도
![](https://i.imgur.com/6LXyGzc.png)

# 고민과 해결 


## 1️⃣ 네트워크 타겟 설정할 때 코드 깔끔하게 하려는 시도

-  이전에는 BaseTareget에 content-type, header-type 등이 있었는데, 지금은 HTTP Header 만 만들고, 그 안에서 열거형 케이스를 분리해서 코드를 숨김
- 또한 분리한 열거형 케이스에서 딕셔너리 값으로 표현해서, 세부적으로 숨김
    
    
```swift
//MARK: - BaseTarget
    var header: HTTPHeader? {
        switch self {
        case .requestAuthorizeCode:
            return nil
        case .requestAccessToken:
            return .oauth
        case .requestIssueList(let token), .requestLoginStatus(let token):
            return .githubAPIRequest(token: token)
        }
    }


//MARK: - HTTPHeader

enum HTTPHeader {
    case oauth
    case githubAPIRequest(token: String)

    var dictionary: [String: String] {
        switch self {
        case .oauth:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        case .githubAPIRequest(let token):
            return [
                "Content-Type": "application/json",
                "Accept": "application/vnd.github.v3+json",
                "Authorization": "token \(token)"
            ]
        }
    }

}

```
## 2️⃣ 사용자의 민감정보, 토큰 값, client_id, client_secret 등을 어떻게 코드에서 숨길지 고민

* XCConfig를 현업에서도 종종 사용한다 하여 사용함
* 다만, GitHub에 올라가는 만큼 그 부분은 `.gitignore`에서 추적할 파일에서 제외하였음
    
## 3️⃣ 네트워크 계층 추상화 : IssueTrackerTarget, BaseTarget, Repository, Provider 등의 역할과 의미

* 처음 하게된 계기는 이 프로젝트에서 네트워크를 요청하는 코드가 많은데 그 사이에 재사용성을 높혀보자한 것이 시작입니다.
* 그러다가 네트워크 리퀘스트 스타일이라는 키워드를 알게되어서 공부하였습니다.
    * TinyNework
    * Alamofire
    * Moya
* 등을 학습하다 URL Session을 사용하여 하는 코드베이스를 구현해려는 점과 코드가 그렇게 많지 않아 `TinyNetwork`를 모방해서 작성해보았습니다.
* 그 결과 새로운 Network 요청 흐름이 생겨도 IssueTrackerTarget에서 케이스만 추가해주면 상황에 맞는 속성 값들을 추가해 주어 편리해졌습니다.
```swift
//MAKR: - Target이 가져야 하는 속성 정의
/// baseURL, path, HTTPheader, HTTPmethod 등
protocol BaseTarget {}

//MARK: - case 마다 네트워크 요청 흐름을 가정해서 HTTPHeader와 Body등을 구성
enum IssueTrackerTarget: BaseTarget {}

//MAKR: - 정의된 Target을 매개변수로 넘겨받아 URLRequest를 만들거나, urlRequest로 네트워크 요청하는 메소드로 구성
class Provider {}

//MARK: - Provider의 클래스 메서드만을 이용해서 서버에 요청을 보냄
class LoginRepository {}
class IssueTrackingRepository {}
```

## 4️⃣ MVVM을 위해 객체간 바인딩 방식의 고민과 그 선택의 이유

-  mvvm 구조에 따라 viewModel의 값이 변경될 때 View가 이를 알아 업데이트 할수있도록 VM-View 간 바인딩의 필요성을 깨달음.
-  초기에는 **클로저 바인딩 방식** 으로 뷰모델의 상태가 없데이트 될때 View에게 알려주도록 시도함 
- **상태 변화가 필요한 프로퍼티가 늘어남에 따라 클로저의 양이 늘어나는 문제가 있었음**
- 클로저 대신 값이 설정되면 등록된 listener에게 상태값과 시점을 전달 해줄 수 있는 **`Observable` 객체를 활용하여 리팩토링** 을 진행.
- 어떤 프로퍼티의 값을 관찰하는지 보기가 용이하고, 후에 Rxswift 를 학습을 하기 위해 기본이 되는 관찰자 패턴 흐름을 알 수 있었음. 

 ```swift
class Observable<T> {

    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
}

 ```

 
