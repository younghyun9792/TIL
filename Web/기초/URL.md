# **URL**

<Br>

### URL(Uniform Resource Locator)은 웹을 뒷받치는 주소 체계이다. 웹은 수 많은 파일이 연결되어 있는 공간이라, 웹에 존재하는 파일을 다른 파일과 구별하는 효과적인 식별자가 필요한데, 웹에선 파일을 자원(Resource)라고 한다. 웹에서 자원을 구별하는 식별자가 바로 URL이다.
### **즉, URL은 웹에서 접근가능한 자원의 주소를 일관되게 표현하는 방식이다.**

<br><br>

- - -

<br>

## **URL의 구성**

<br>

![이미지](https://kr.object.ncloudstorage.com/dreamhack-content/page/12895a254539b5a98d3e22c6af025882215271a3231744279101323df838a1a2.png)

<br>

|   **요소**    |   **설명**    |
|    :---:       |     :---:      |
|     **Schema**      |     웹 서버와 어떤 프로토콜로 통신할지 나타낸다.      |
|   **Host**    |   Authority의 일부로, 접속할 웹 서버의 주소에 대한 정보를 가지고 있다.    |
|   **Port**    |   Authority의 일부로, 접속할 웹 페이지의 포트에 대한 정보를 가지고 있다.
|   **Path**    |   접근할 웹 서버의 리소스 경로로 '/'로 구분된다.  |
|   **Query**   |   웹 서버에 전달하는 파라미터로, URL에서 '?'뒤에 위치하며 &를 사용해 여러 개가 나올 수 있다.  |
|   **Fragment**    |   메인 리소스에 존재하는 서브 리소스를 접근할 떄, 식별하기 위한 정보를 담고 있으며 '#' 뒤에 위치한다.

<br><br>

<br>

> ## **URL, URI, URN**
> ### **URI(Uniform Resource Identifier)에는 두 가지 형태가 있는데, 그 두개가 URL(Uniform Resource Locator)과 URN(Uniform Resource Name)** 이다.
> ### URL은 우리가 흔히 보는 URL주소이고, **URN은 URL의 한계**(URL은 주소라, 특정 위치를 나타내는데 해당 리소스가 옮겨지면 URL은 더는 사용할 수 없음)에 의해 만들어져서, 위치가 바뀌더라도 리소스의 위치를 찾을 수 있도록 **객체의 주소가 아닌 객체를 직접 가르킨다.**
> 
> 
> ### **즉, URL,URN은 URI의 종류이다. 즉, 모든 URL은 URI이고, 모든 URN은 모든 URI이지만 URL과 URN은 다르므로, 모든 URI는 URL이 아니다.**