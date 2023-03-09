# CC Attack

<br>

`CC Attach(Cache-Control Attack)` 이란 [GET Flooding](HTTP%20GET%20Flooding.md)과 자주 함께 사용되는 공격으로, 웹서버의 부하를 감소시키기 위해 사용하는 `Cache` 옵션을 조작하여 웹서버가 직접 처리하도록 하여 부하를 주는 공격이다.

 `no-store` 옵션과, `must-revalidate` 옵션을 활성화시킨다.

<br>

```jsx
GET / HTTP1.1
Host : 192.168.64.1:3000
Cache-Control: no-store,/w must-revalidate
```

- no-store :  요청받은 데이터를 캐싱서버에 저장하는 것을 방지한다.
- must-revalidate : 캐싱버서와 같은 별도의 시스템을 운영하는 경우, 웹서버가 캐싱서버에 저장된 캐시데이터에 대한 검증을 요구할 수 있다. 이 시지사를 추가할 경우 무조건 Server에서 재검증한 후 응답 값을 받게 된다.

<br><br>

---

<br>

## 대응 방안

- 방화벽에서 CC Attack의 문자열을 포함한 IP를 차단한다.(no-store, must-revalidate를 포함하는 경우)