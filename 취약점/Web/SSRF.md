# **SSRF**

<br>

### 서비스 간 HTTP 요청이 이루어 질 땨, 요청 내에 이용자의 입력값이 포함 될 수 있는데, 이용자의 입력값이 포함될 때 개발자가 의도하지 않은 요청이 전송될 수 있음.

### Server-side Request Forgery(SSRF)는 웹 서비스의 요청을 변조하는 취약점으로, 브라우저가 변조된 요청을 보내는 CSRF와는 다르게 웹 서비스의 권한으로 변조된 요청을 보낼 수 있음.

### 최근, 대다수 서비스들은 마이크로서비스로 구조를 많이 바꾸고, 새롭게 개발하는 추세이기 때문에 SSRF 취약점의 파급력이 더욱 높아지고 있음.


<br>
<br>


> ### 마이크로 서비스란?
> 소프트웨어가 잘 정의된 API를 통해 통신하는 소규모의 독립적인 서비스로 구성되어 있는 경우의 소프트웨어 개발을 위한 아키텍처 및 조직적 접근 방식이다. 이러한 서비스는 독립적인 소규모 팀에서 보유한다.

<br>

- - -

<br>

### 웹 서비스는 외부에서 접근할 수 없는 내부망의 기능을 사용할 떄가 있는데, 대표적으로 백오피스 서비스를 예로 들 수 있음.

### 백오피스 서비스는 관리자 페이지라고 불리며, 게정 정지, 삭제 등 관리자만 수행할 수 있는 기능을 구현한 서비스임. admin 페이지 라고 불리기도 하며, 이런 서비스는 관리자만 이용할 수 있어야 하기 때문에 내부망에 위치됨.

### 웹 서비스에서는 웹 서비스 외부에서 직접 접근할 수 없는 내부망과 통신할 수 있는데, 만약 공격자가 SSRF 취약점을 통해 웹 서비스의 권한으로 요청을 보낼 수 있다면, 공격자는 외부에서 간접적으로 내부망 서비스(관리자 권한)을 사용할 수 있고, 이는 치명적인 피해를 입힐 수 있음.

### 웹 서비스가 보내는 요청을 변조하기 위해서는 요청 내에 이용자의 입력값이 포함되야 함.

<br>

- - -

<br>

## URL이 포함되는 경우

<br>

```py
from flask import Flask, request
import requests
app = Flask(__name__)
@app.route("/image_downloader")
def image_downloader():
    # 이용자가 입력한 URL에 HTTP 요청을 보내고 응답을 반환하는 페이지 입니다.
    image_url = request.args.get("image_url", "") # URL 파라미터에서 image_url 값을 가져옵니다.
    response = requests.get(image_url) # requests 라이브러리를 사용해서 image_url URL에 HTTP GET 메소드 요청을 보내고 결과를 response에 저장합니다.
    return ( # 아래의 3가지 정보를 반환합니다.
        response.content, # HTTP 응답으로 온 데이터
        200, # HTTP 응답 코드
        {"Content-Type": response.headers.get("Content-Type", "")}, # HTTP 응답으로 온 헤더 중 Content-Type(응답 내용의 타입)
    )
@app.route("/request_info")
def request_info():
    # 접속한 브라우저(User-Agent)의 정보를 출력하는 페이지 입니다.
    return request.user_agent.string
app.run(host="127.0.0.1", port=8000)
```

<br>

### 다음과 같은 코드가 있을 때, 입력값으로 https://dreamhack.io/assets/dreamhack_logo.png 를 넣게 되면, 드림핵 페이지에 요청을 보내고 응답을 반환함.

### 코드에서 반환하는 값은 아래를 반환함. HTTP 응답으로 온 데이터, 응답 코드, Content_type을 반환함.

```
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4558.0 Safari/537.36
```

<br>

### 그리고, 인자로 http://127.0.0.1:8000/request_info 를 입력하게 되면, http://127.0.0.1:8000/request_info URL에 HTTP 요청을 보내고, 응답을 반환함. 반환한 값을 확인해보면 request_info 엔드포인트에 접속했을 때와 다르게 브라우저 정보가 python-requests/2.11.1임.

### 접속한 브라우저 정보로 python-requests가 출력된 이유는 ,웹 서비스(python백엔드)에서 HTTP 요청을 보냈기 때문임. 이처럼, 이용자가 웹 서비스에서 사용하는 마이크로 서비스의 API 주소를 알아내고, image_url에 주소를 전달하면 외부에서 직접 접근할 수 없는 마이크로 서비스의 기능을 임의로 사용할 수 있음.

- - -

<br>

## **웹 서비스의 요청 URL에 이용자의 입력값이 포함되는 경우**

<br>

```py
INTERNAL_API = "http://api.internal/"
# INTERNAL_API = "http://172.17.0.3/"
@app.route("/v1/api/user/information")
def user_info():
	user_idx = request.args.get("user_idx", "")
	response = requests.get(f"{INTERNAL_API}/user/{user_idx}")
@app.route("/v1/api/user/search")
def user_search():
	user_name = request.args.get("user_name", "")
	user_type = "public"
	response = requests.get(f"{INTERNAL_API}/user/search?user_name={user_name}&user_type={user_type}")
```

<br>

### 다음과 같은 코드가 있을 때 user_info에서 인자를 1을 줄 시 http://api.internal/user/1의 주소로 요청을 보냄.

### 하지만 user_idx의 인자를 ../로 줄 시 웹 서비스는 http://api.internal/search에 요청을 보냄. 해당 취약점은 경로를 변조한다는 의미에서 Path Traversal이라고 불림.

<br>

### 그리고, user_search함수에서 user_name의 값을 hello로 줄 시 http://api.internal/user/search?user_name=hello&user_type=public의 주소로 요청을 보냄

### 하지만, secret&user_type=private#를 입력할 경우 웹 서비스는 http://api/internal/search?yuser_name=secret&user_type=pirvate의 주소로 요청을 보냄. #을 이용해, 뒤의 문자열은 주석처리함.

<br>

- - -

<br>

## **웹 서비스의 요청 Body에 이용자의 입력값이 포함되는 경우**

<br>

```py
from flask import Flask, request, session
import requests
from os import urandom
app = Flask(__name__)
app.secret_key = urandom(32)
INTERNAL_API = "http://127.0.0.1:8000/"
header = {"Content-Type": "application/x-www-form-urlencoded"}
@app.route("/v1/api/board/write", methods=["POST"])
def board_write():
    session["idx"] = "guest" # session idx를 guest로 설정합니다.
    title = request.form.get("title", "") # title 값을 form 데이터에서 가져옵니다.
    body = request.form.get("body", "") # body 값을 form 데이터에서 가져옵니다.
    data = f"title={title}&body={body}&user={session['idx']}" # 전송할 데이터를 구성합니다.
    response = requests.post(f"{INTERNAL_API}/board/write", headers=header, data=data) # INTERNAL API 에 이용자가 입력한 값을 HTTP BODY 데이터로 사용해서 요청합니다.
    return response.content # INTERNAL API 의 응답 결과를 반환합니다.
@app.route("/board/write", methods=["POST"])
def internal_board_write():
    # form 데이터로 입력받은 값을 JSON 형식으로 반환합니다.
    title = request.form.get("title", "")
    body = request.form.get("body", "")
    user = request.form.get("user", "")
    info = {
        "title": title,
        "body": body,
        "user": user,
    }
    return info
@app.route("/")
def index():
    # board_write 기능을 호출하기 위한 페이지입니다.
    return """
        <form action="/v1/api/board/write" method="POST">
            <input type="text" placeholder="title" name="title"/><br/>
            <input type="text" placeholder="body" name="body"/><br/>
            <input type="submit"/>
        </form>
    """
app.run(host="127.0.0.1", port=8000, debug=True)
```

<br>

### 다음과 같은 코드가 있을 때, 입력창에 값을 입력하고 제출 버튼을 누를 시 다음과 같은 응답을 받을 수 있음.

```json
{ "body" : "body", "title" : "title", "user" : "guest" }
```

<br>

### 요청을 전송할 때 세션 정보를 "guest"로 설정했기 때문에 "user"가 "guest"인 것을 확인할 수 있음. 예시 코드를 살펴보면, 내부 API로 요청을 보내기 전, 다음과 같이 데이터를 구성함.

```json
data = f"title={title}&body={body}&user={session['idx']}
```

<br>

### 데이터를 구상할 때 이용자의 입력값인 title, body, 그리고 user의 값을 파라미터 형식으로 설정하는데, 이로 인해 이용자가 URL에서 파라미터를 구분학 ㅣ위해 사용하는 구분 문자인 &를 포함하면 설정되는 data의 값을 변조할 수 있음.

### title의 값을 title&user=admin을 삽입 시, 내부 API에서 전달받은 값을 파싱할 때 앞에 존재하는 파라미터의 값을 가져와 사용하기 때문에 user의 값을 벼놎할 수 있음.

```json
{ "body": "body", "title": "title", "user": "admin" }
```