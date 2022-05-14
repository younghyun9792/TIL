# **File Upload**

<br>

<br>

### **File Upload** 취약점이란 공격자의 파일을 웹 서비스의 파일 시스템에 업로드 하는 과정에서 발생하는 보안 취약점이다.

### 악성 확장자를 갖는 파일을 업로드할 수 있을 때 발생하고, 원하는 시스템 커맨드를 실행하는 원격 코드 실행 취약점을 유발할 수 있다.

### 파일 업로드 취약점은 크게 Path Traversal과 악성 파일 업로드로 분류되고, 파일 업로드를 허용하는 보통의 서비스는 보안을 위해 특정 디렉터리에만 업로드를 허용한다.

### 하지만, 만약 이런 제약이 없다면 악의적인 이용자가 웹 서버의 소스 코드나 서버에 있는 중요 시스템 파일의 코드를 덮어 쓸 위험이 있다.
<br>

- - -

<br>

## Path Traversal

<br>

### Path Traversal 취약점은 업로드에 존재하는 이러한 제약을 우회하여, 임의 디렉터리에 파일을 업로드할 수 있는 취약점을 말한다.

<br>

```py
from flask import Flask, request
app = Flask(__name__)
@app.route('/fileUpload', methods = ['GET', 'POST'])
def upload_file():
	if request.method == 'POST':
		f = request.files['file']
		f.save("./uploads/" + f.filename)
		return 'Upload Success'
	else:
		return """
		<form action="/fileUpload" method="POST" enctype="multipart/form-data">
			<input type="file" name="file" />
			<input type="submit"/>
		</form>
		"""
if __name__ == '__main__':
	app.run()
```

<br>

### 이런 코드가 있을 떄, /fileupload는 POST 요청을 받으면 클라이언트가 전송한 파일을 ./uploads에 저장하는데, 이용자가 입력한 파일 이름 f.filename을 그대로 가져온다.

### 이렇게 되면, f.filename을 그대로 사용하기 떄문에 Path Traversal에 취약한데, 공격자가 ../와 같은 메타문자를 사용하면 uploads 디렉터리를 벗어나 상위 디렉터리에도 파일을 업로드할 수 있다.

<br><br>

- - -
<br>


## 악성 파일 업로드

<br>

### 악성 파일 업로드 취약점은 이용자가 파일을 업로드할 때, 이를 제대로 검사하지 않아서 발생하는 취약점을 말한다.

### 웹 서버는 .php, .jsp, .asp와 같은 확장자의 파일을 Common Gateway Interface(CGI)로 실행하고, 그 결과를 이용자에게 반환한다.

```
<FilesMatch ".+\.ph(p[3457]?|t|tml)$">
    SetHandler application/x-httpd-php
</FilesMatch>
```

### 해당 파일은 파일의 확장자가 정규표현식 ".+\.ph(p[3457]?|t|tml)$"를 만족하면 x-httpd-php로 핸들링하게 하는 Apache 설정 파일인데, x-httpd-php는 PHP 엔진이며, 요청한 파일을 실행하고 그 결과를 반한한다.

### .php, php3, phtml 등이 위의 정규표현식을 만족하는데, 즉 공격자가 임의의 php 소스 파일을 .php 확장자로 업로드하고, GET 요청을 보낼 수 있다면 CGI에 의해 해당 코드가 실행되도록 할 수 있다.

### 웹 브라우저는 파일의 확장자나 응답의 Content-Type에 따라 요청을 다양하게 처리하는데, 만약 공격자가 서버에 exploit.html을 업로드하고, 이에 전급하는 url이 https://dreamhack.io/uploads/exploit.html라면 브라우저는 이를 HTML로 인식한다.

### 해당 html파일에 악의적인 스크립트를 삽입하면 XSS공격으로 이어질 수 있다.