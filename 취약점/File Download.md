# **File Download**

<br>

<br>

### **File Download**취약점이란 웹 서비스에 존재하는 파일 시스템에 존재하는 파일을 다운로드 하는 과정에 발생하는 보안 취약점이다.

### 공격자는 웹 서비스의 파일 시스템에 존재하는 임의의 파일을 다운로드 받을 수 있다.

### 설정 파일, 패스워드 파일, 데이터 베이스 백업 본 등을 다운로드 하여 민감한 정보를 탈취할 수 있고 2차 공격을 수행할 수 있다.

### FIle Download 취약점은 이용자가 다운로드할 파일의 이름을 임의로 정할 수 있을 때 발생하며, Path Traversal 취약점과 함께 사용된다..

<br>

- - -

<br>

### 다음은 파일 다운로드 취약점이 자주 발생하는 URL 패턴이다.

```
https://vulnerable-web.dreamhack.io/download/?filename=notes.txt
```
```
https://vulnerable-web.dreamhack.io/download/?filename=../../../../../../etc/passwd
```
```
https://vulnerable-web.dreamhack.io/images.php?fn=6ed0dd02806fa89e233b84f4.png
```

<br>

