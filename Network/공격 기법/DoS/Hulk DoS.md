# Hulk DoS

<br>

`Hulk DoS`란 웹서버의 가용량(웹서버로 접속할 수 있는 클라이언트 수)를 모두 사용하도록 하여, 정상적인 서비스가 불가능하도록 유도하는 `GET Flooding` 공격이다.

DDoS 차단 정책을 피하기 위해 공격 대상 웹사이트 주소(URL)을 지속적으로 변경한다.

```jsx
HTTP 192.168.0.1/?ABasdg=2vaewv
HTTP 192.168.0.1/?tbsehs=ybseyb
HTTP 192.168.0.1/?yb2434=nu6358
HTTP 192.168.0.1/?246bse=im7494
```

이런 식으로 파라미터를 지속적으로 변경하여 웹서버로 전달한다.

<br><br>

---

<br>

## 대응 방법

- 접속 임계치 설정(특정 IP에서 연결할 수 있는 동시 접속수-Concurrent Connection에 대한 최대값을 설정)
- HTTP Request HOST 임계치를 설정한다. URL을 계속 변경하기 때문에, URL이 아닌 `HTTP Request`에 포함된 `HOST` 필드 값을 카운트한다.
- 302-Redirect를 이용해 차단한다. 대부분의 DDoS 공격도구는 302-Redirect에 대해 반응하지 않으므로, 웹사이트의 여러 URL 중 공격당하기 쉬운 URL에 대한 Redirect 처리를 통해 DDoS 공격도구를 활용한 공격을 사전에 차단할 수 있다.