# **TCP/IP 4계층**
<br>

### `TCP/IP 4 Layer`는 TCP/IP(인터넷 통신을 위한 표준 프로토콜 스위트)에서 사용하는 모델이다.
<br>

### [`OSI 7 Layer`](OSI%207계층.md)보다 먼저 개발되었고, 계속 표준화되어 신뢰성이 우수하다.

<br>
<br>

- - -

<br>

## **OSI 7계층과 비교**

<br>

![](https://velog.velcdn.com/images/younghyun/post/49a52ac3-e234-4c68-9d69-11b376edb49c/image.png)

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