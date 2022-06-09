# **3-Way Handshake & 4-Way Handshake**

<br>

### [`3-Way Handshake`](#3-way-handshake)는 [TCP](./../프로토콜/TCP.md)에서 **연결을 설정**하는 과정이다.
<br>

### [`4-Way HandShake`](#4-way-handshake)는 [TCP](./../프로토콜/TCP.md)에서 **연결을 해제**하는 과정이다.

<br><br>

## **3-Way Handshake**

<br>

### 3-Way Handshake는 [TCP](./../프로토콜/TCP.md) 통신을 이용하여 데이터를 전송하기 위해 네트워크 연결을 **설정(Connection Establish)**하는 과정이다.
<br>

### 양쪽 모두 데이터를 전송할 준비가 되었다는 것을 보장하고, 실제로 데이터 전달을 시작하기 전에 한 쪽에서 다른 쪽이 준비되었다는 것을 알 수 있도록 한다.

<br>

### 즉, [TCP/IP](TCP／IP%204계층.md) 프로토콜을 이용해서 통신을 하는 응용 프로그램이 데이터를 전송하기 전에, 먼저 정확한 전송을 보장하기 위해 상대방 컴퓨터와 사전에 세션을 수립하는 과정을 말한다.


<br>

![](https://velog.velcdn.com/images/younghyun/post/1559d0f9-b1bb-4066-be78-4cd05ca76db9/image.png)

<br>

### Step 1 (SYN)
#### 클라이언트는 서버와 커넥션을 연결하기 위해 SYN을 보낸다.
#### 송신자가 최초로 데이터를 전송할 때 Sequence Number를 임의의 랜덤 숫자로 지정 후, SYN 플래그 비트를 1로 설정한 세그먼트를 전송한다.
#### Client : `CLOSED` - `SYN_SENT`
#### Server : `LISTEN`

<br>

### Step 2 (SYN+ACK)
#### 서버가 SYN(x)을 받고, 클라이언트에게 받았다는 신호인 ACK와 SYN 패킷을 보낸다. (seq : y, ACK : x + 1)
#### ACK Number 필드를 Sequence Number + 1 로 지정하고, SYN과 ACK 플래그 비트를 1로 설정한 세그먼트 전송


<br>

### Step 3 (ACK)
#### 클라이언트는 서버의 응답은 ACK(x+1)와 SYN
<br><br>


## **4-Way Handshake**

<br>

### 