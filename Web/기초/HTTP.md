# **HTTP**

<br>

### **HTTP(Hyper Text Transfer Protocol)** 란 [클라이언트와 서버](%ED%81%B4%EB%9D%BC%EC%9D%B4%EC%96%B8%ED%8A%B8%EC%99%80%20%EC%84%9C%EB%B2%84.md)의 데이터 교환을 요청(Request)과 응답(Response) 형식으로 정의한 프로토콜로, 현대 웹 서비스의 바탕이 된다.

<br>

### HTTP의 기본 메커니즘은 클라이언트가 **서버에게 요청(Request)하면, 서버가 응답(Response)하는 것**으로 웹 서버는 HTTP 서버를 HTTP 서비스 [포트](/Network/기초/포트(Port).md)에 대기시킨다. 이 [포트](/Network/기초/포트(Port).md)는 일반적으로 TCP/80 또는 TCP/8080이다. 클라이언트가 서비스 [포트](/Network/기초/포트(Port).md)에 HTTP 요청을 전송하면 서버가 이를 해석하여 적절한 응답을 반환한다.

<br><br>

- - -

## **HTTP 요청**

<br>

### HTTP 요청은 서버에게 특정 동작을 요구하는 메시지로, 서버는 해당 동작이 실현 가능한지, 클라이언트가 그러한 동작을 요청할 권한이 있는지 등을 검토하고 적절할 때만 이를 처리한다.

<br>

```
GET /index.html HTTP/1.1
Host: dreamhack.io
Connection: keep-alive
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36
```

<br>

### 위에서 시작 줄은 **메소드(Method)**와 **요청 URI**, 그리고 **HTTP 버전**으로 구성되고 띄어쓰기로 구분되는데 위 요청은 GET메소드로 '/index.html'경로로 HTTP버전 1.1로 요청했다. 아래 헤더엔 여러 정보가 담겨 있다.

<br><br>

- - -

## HTTP 응답

<br>

### HTTP 응답은 HTTP 요청에 대한 결과를 반환하는 메시지로, 요청을 수행 했는지, 하지 않았는지, 안했다면 왜 안 했는지와 같은 **상태 정보(Status)**과 **클라이언트에게 전송할 리소스**가 포함된다.

<br>

```
HTTP/1.1 200 OK
Server: Apache/2.4.29 (Ubuntu)
Content-Length: 61
Connection: Keep-Alive
Content-Type: text/html

<!doctype html>
<html>
<head>
</head>
<body>
...
</body>
</html>
```

<br>

### HTTP 응답의 시작 줄은 HTTP 버전(Status Code)과 상태 코드, 그리고 처리 사유(Reason Phrase)로 구성되며, 띄어쓰기로 구분된다. HTTP 버전은 서버에서 사용하는 HTTP프로토콜의 버전을, 상태 코드는 요청에 대한 처리 결과를 세 자릿수로 나타낸다. HTTP 표준인 [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec6.html)은 대략 40여개의 상태 코드를 정의하는데, 각각 첫 번째 자리수에 따라 5개의 클래스로 분류되며, 처리사유는 상태 코드가 발생한 이유를 짧게 기술한 것이다.

<br>

|**상태코드**|**설명**|**대표예시**|
|:---:|:---:|:---:|
|**1xx**|요청을 제대로 받았고, 처리가 진행중임.||
|**2xx**|요청이 제대로 처리됨.|200:성공|
|**3xx**|요청을 처리하려면 클라이언트가 추가 동작을 취해야 함.|302:다른 URL로 갈 것.|
|**4xx**|클라이언트가 잘못된 요청을 보내 처리에 실패함.|404:리소스가 없음,403:클라이언트가 요청할 권한이 없음.|
|**5xx**|클라이언트의 요청은 유효하나, 서버에서 에러가 발생해 처리에 실패함.|503:서버가 과부화로 인해 요청을 처리할 수 없음.

<br><br><br>


<br>

# **HTTPS**
<br>

### HTTP의 요청과 응답은 평문으로 전달되어, 누군가 이걸 가로챈다면 중요한 정보(로그인 ID,PASSWORD...)등이 유출될 수 있다. **HTTPS(HTTP over Secure Socket Layer)**는 TLS(Transport Layer Security)프로토콜을 도입하여 이런 문제점을 보완한다. TLS는 서버와 클라이언트 사이에 오가는 모든 HTTP 메세지를 암호화하며, 즉 공격자가 중간에 메시지를 탈취하더라도 해석할 수 없다. 즉, 도청과 변조로부터 보호된다.
### HTTPS 초기에는 금융이나 정부 서비스 같이 민감한 데이터를 취급하는 웹 서비스에만 HTTPS가 사용됐지만 현재는 규모와 상관없이 HTTPS를 사용하는 추세다.
### 웹 서버의 URL이 http://로 시작되면 HTTP, https://로 시작하면 HTTPS 프로토콜이다.

<br><br>

### 아래는 HTTP프로토콜의 패킷을 와이어샤크로 분석한 것으로, 평문이 그대로 나와 있는 것을 볼 수 있다.

<br>


![](https://velog.velcdn.com/images/as979200/post/d6afad1c-5c3c-417c-b450-ac96ae14d02a/image.png)


<br><br>

### 하지만, HTTPS 프로토콜의 패킷은 암호화되어 해석할 수 없는 걸 볼 수 있다. 빨간 건 요청, 파란 건 응답이다.

<br>

![](https://velog.velcdn.com/images/as979200/post/bb74f65c-005c-4f91-8014-fa0b7e50711a/image.png)
