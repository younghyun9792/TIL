# **TCP/IP 4계층**
<br>

### `TCP/IP 4 Layer`는 TCP/IP(인터넷 통신을 위한 표준 프로토콜 스위트)에서 사용하는 모델이다.
<br>

> ### TCP/IP란??
> `TCP(Transmission Control Protocol)`과 `IP(Internet Protocol)`의 약자이다.
> IP를 사용 시 데이터를 전달할 수 있지만, 순서가 이상할 수도 있고 전달 여부를 보증하지 않는다.
> TCP는 IP 위에서 동작하는 프로토콜인데, IP의 문제점인 순서와 전달 여부를 해결해준다.
> 즉, TCP/IP는 **IP를 이용해 목적지에 도달하고, TCP를 활용해 연결을 맺고 신뢰성을 유지할 수 있도록 하겠다는 것**을 의미한다.
> 그리고, HTTP, FTP처럼 TCP를 기반으로 한 우리가 자주 사용하는 여러 응용프로토콜이 IP 위에서 같이 동작하기 때문에 이런 여러 프로토콜들을 묶어 **`TCP/IP`** 라고 부른다. 
> **현재 대다수의 프로그램이 TCP/IP로 통신하고 있다.**


<br>

### [`OSI 7 Layer`](OSI%207%EA%B3%84%EC%B8%B5.md)보다 먼저 개발되었고, 계속 표준화되어 신뢰성이 우수하다.

<br>

- - -

<br>

## **OSI 7계층과 비교**

<br>

![](https://velog.velcdn.com/images/younghyun/post/7c29cf72-4ff2-4668-ba41-b71ec79af57b/image.png)

<br><br>

- - -

<br>

## **TCP/IP 4계층**

<br>

|TCP/IP 4계층|역할|전송 단위|전송 주소|프로토콜|장비|
|:---:|:---:|:---:|:---:|:---:|:---:|
|응용 계층(Application)|응용프로그램 간의 데이터 송수신|Data/Message|-|FTP ,SMTP ,HTTP ,DNS...|-|
|전송 계층(Transport)|호스트 간의 자료 송수신|Segement|Port|TCP,UDP...|게이트웨이|
|인터넷 계층(Internet)|데이터 전송을 위한 논리적 주소 지정 및 경로 지정|Packet|IP|IP ,ARP ,ICMP...|라우터|
|네트워크 연결 계층(Network Access)|실제 데이터인 프레임을 송수신|Frame|MAC|Ethernet ,PPP ,Token Ring...|브릿지, 스위치|