# **CSRF란?**

<br>

### **CSRF(Cross-site-Reqyest0Firgery)** 는 웹 서비스가 쿠키 또는 세션을 사용해 이용자를 세션 하는 걸 이용해서, 임의 사용자의 권한으로 특정 주소에 HTTP 요청을 보낼 수 있는 취약점이다.

### 공격자는 해당 취약점을 통해 이용자의 권한으로 서비스 기능을 사용해 이득을 취할 수 있다. 예를 들어, 금액을 송금하거나, 비밀번호를 변경 후 계정을 탈취하거나, 관리자 계정을 공격해 공지사항을 작성하는 등 혼란을 야기할 수 있다.

<br>

- - -

<br>

## **CSRF 동작**

<br>

* ### CSRF 공격에 성공하기 위해서는 공격자가 작성한 악성 스크립트를 이용자가 실행해야 한다. 이는 공격자가 이용장게 메일을 보내거나, 게시판에 글을 작성하는 등 여러 유도방법이 있다.
* ### CSRF는 HTML 또는 Javascript를 통해 작성할 수 있는데, 이미지를 불러오는 img 태그나, form 태그 등이 있다.
<br>

```html
<img src = "http://bank.dreamhack.io/sendmoney?to=dreamhack&amount=1337" width=0px height=0px>
```
<br>

* ### 이 코드는 img 태그를 이용해 해당 url에 접속하는데, 접속 시 로그인(쿠키,세션)이 되있을 시, dreamhack 유저에게 1337원을 보내는 행동이 실행된다.
* ### 게다가, width와 hieght 옵션으로  보이지도 않게 할 수 있다.

<br>

* ### 또는 Javascript로 아래와 같이 작성할 수 있다.

<br>

```js
/* 새 창 띄우기 */
window.open('http://bank.dreamhack.io/sendmoney?to=dreamhack&amount=1337');
/* 현재 창 주소 옮기기 */
location.href = 'http://bank.dreamhack.io/sendmoney?to=dreamhack&amount=1337';
location.replace('http://bank.dreamhack.io/sendmoney?to=dreamhack&amount=1337');
```

<br>

- - -

<br>

## **XSS와의 차이**

<br>

* ### XSS와 CSRF는 스크립트를 웹 페이지에 작성하여 공격한다는 점에서 유사하다. 두 개의 공통점, 차이점은 아래와 같다.

<br>

## 공통점

<br>

* ### 두 개의 취약점 모두 클라이언트가 공격 대상이고, 이용자가 악성 스크립트가 포함된 페이지에 접속하도록 유도한다.

<br>

## 차이점
<br>

* ### 두 개의 취약점은 공격에 있어서 서로 다른 목적을 가진다. XSS는 인증 정보인 세션, 쿠키의 탈취를 목적으로 하지만, CSRF는 이용자의 권한으로 특정 페이지에 HTTP요청을 보내는 것을 목적으로 한다.

<br>

### 즉, XSS는 **사용자가 특정 웹사이트를 신용**하는 점을 노린 것이라면, CSRF는 **특정 웹사이트가 사용자의 웹 브라우저를 신용**하는 상태를 노린 공격이다.