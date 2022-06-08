# **TCL SYN Flooding**

<br>

### `TCP SYN Flooding`은 **[TCP](./../../프로토콜/TCP.md)의 연결과정(3 Way Handshake)의 취약점**을 이용하여 공격한다.

<br>

### `Backlog Queue`는 서버가 접속자(Clinet or Hacker)의 연결 요청을 대기할 때, **요청 정보를 저장**하는 공간이다.
### 만약 정상 연결이 되었다면(ESTABLISHED), Backlog Queue 공간에서 연결 요청정보가 삭제되어서 공간이 계속 유지된다.

### 하지만, 연결이 정상적으로 진행되지 않으면, 접속 정보(SYN_RECV)가 계속 Backlog Queue에 쌓이게 되고, **결국 Backlog Queue를 꽉 채워 다른 연결 요청 정보를 저장할 수 없게** 된다.

<br>

![](https://velog.velcdn.com/images/younghyun/post/0c3c397c-bb32-47b2-a64e-fe3ab49d3cc8/image.png)

<br>
<br>

- - -
<br>

## **공격과정**

<br>

### 1. 공격자 서버에 연결 요청(SYN) 전송.
### 2. 서버는 연결 요청에 응답(SYN, ACK) 전송.
### **3. 공격자가 ACK를 보내지 않음. 서버는 Backlog Queue에 정보 저장 후 대기중.**
### 4. 공격자가 서버에 다시 연결 요청(SYN) 전송, 위 과정을 반복

<br>

### 해당 공격으로, 서버의 Backlog Queue에 공격자의 **SYN 요청을 계속 대기시키므로, Queue가 계속해서 쌓임.**
### 한정적인 Backlog Queue의 공간이 공격자로 인해 꽉 채워지면, **정상 Client 접속 시 SYN(연결 요청)을 보내도 서버가 ESTABLISHED(연결 수립)을 할 수 없음.**

<br><br>

- - -

<br>

## **대응책**

<br>

### 1. Backlog Queue의 Size를 늘린다.
<br>

### 2. SYN Cookie를 설정한다.

<br>

### 3. 방화벽의 동일 클라이언트 IP애 대해 SYN(연결 요청) 임계치를 설정한다.
### 이 설정을 할 시, 클라이언트로부터 ACK를 받아야 Backlog Queue에 연결 요청정보를 저장함.

<br>

### 4. TCP 연결 과정 대기시간을 줄인다.