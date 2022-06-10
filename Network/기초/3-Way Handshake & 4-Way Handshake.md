# **3-Way Handshake & 4-Way Handshake**

<br>

### **`3-Way Handshake`** 는 [TCP](./../프로토콜/TCP.md)에서 **연결을 설정**하는 과정이다.
<br>

### **`4-Way HandShake`** 는 [TCP](./../프로토콜/TCP.md)에서 **연결을 해제**하는 과정이다.

<br><br>

> ## **SYN, ACK, FIN?**
> ### SYN이나 ACK, FIN 등은 TCP 통신에서 사용하는 [Control Flag](TCP%20Control%20Flag.md)로, URG, PSH, RST등이 추가로 있다.
<br><br>

## **3-Way Handshake**

<br>

### 3-Way Handshake는 [TCP](./../프로토콜/TCP.md) 통신을 이용하여 데이터를 전송하기 위해 네트워크 연결을 **설정(Connection Establish)** 하는 과정이다.
<br>

### 양쪽 모두 데이터를 전송할 준비가 되었다는 것을 보장하고, 실제로 데이터 전달을 시작하기 전에 한 쪽에서 다른 쪽이 준비되었다는 것을 알 수 있도록 한다.

<br>

### 즉, [TCP/IP](TCP／IP%204계층.md) 프로토콜을 이용해서 통신을 하는 응용 프로그램이 데이터를 전송하기 전에, 먼저 정확한 전송을 보장하기 위해 상대방 컴퓨터와 사전에 세션을 수립하는 과정을 말한다.


<br>

![](https://velog.velcdn.com/images/younghyun/post/1559d0f9-b1bb-4066-be78-4cd05ca76db9/image.png)

<br>

## **작동방식**

<br>



### **Step 1 (SYN)**
#### 클라이언트는 서버와 커넥션을 연결하기 위해 SYN을 보낸다.
#### 송신자가 최초로 데이터를 전송할 때 Sequence Number를 임의의 랜덤 숫자로 지정 후, SYN 플래그 비트를 1로 설정한 세그먼트를 전송한다.
#### Client : `CLOSED` - `SYN_SENT`
#### Server : `LISTEN`

<br>

### **Step 2 (SYN+ACK)**
#### 서버가 SYN(x)을 받고, 클라이언트에게 받았다는 신호인 ACK와 SYN 패킷을 보낸다. (seq : y, ACK : x + 1)
#### ACK Number 필드를 Sequence Number + 1 로 지정하고, SYN과 ACK 플래그 비트를 1로 설정한 세그먼트 전송
#### Client : `CLOSED`
#### Server : `SYN_RCV`

<br>

### **Step 3 (ACK)**
#### 클라이언트는 서버의 응답은 ACK(x+1)와 SYN(y) 패킷을 받고, ACK(y+1)을 서버로 보낸다.
#### Client : `ESTABLISHED`
#### Server : `SYN_RCV` => ACK => `ESTABLISHED`
<br><br>

## **4-Way Handshake**

<br>

### 4-Way HandShake는 연결을 해체 (Connection Termination)하는 과정으로, FIN 플래그를 사용한다.

<br>

> ## **Termination의 종류**
> ### `Termination`에는 정상적인 연결 해제인 `Graceful Connection release`와 갑작스런 연결 해제인 `Abrupt Connection release`가 있다.
> ### `Graceful Connection release`는 양쪽의 커넥션이 서로 닫기 전까지 열려 있고, `Abrupt Connection release`는 갑자기 한 TCP 엔티티가 연결을 강제로 닫는다.

<br>

## **작동방식**

<br>

### **STEP1 (Client => Server:FIN(+ACK))**

#### 서버와 클라이언트가 연결된 상태에서 클라이언트가 close()를 호출하여 접속을 끊으려한다.

#### 이때 클라이언트는 서버에게 연결을 종료한다는 `FiN` 플래그를 보낸다.(이떄 FIN 패킷에는 실질적으로 ACK도 포함)

<br>

### **STEP2 (Server => Client:ACK)**
#### 서버는 FIN을 받고, 확인했다는 `ACK`를 클라이언트에게 보내고 자신의 통신을 끝날때까지 기다린다.(TIME_WAIT)
#### 서버는 클라이언트에게 응답을 보내고 `CLOSE_WAIT` 상태에 들어간다. 그리고, 아직 남은 데이터가 있다면 마저 전송을 마친 후 `close()`를 호출한다.
#### 클라이언트에서는 서버에서 ACK를 받은 후에 서버가 남은 데이터 처리를 끝내고 FIN 패킷을 보낼 때까지 기다리게 된다. (FIN_WATI2)
<br>

### **STEP3 (Server => Client:FIN)**
#### 데이터를 모두 보냈다면, 서버는 연결의 종료에 합의 한다는 뜻으로 `FIN` 패킷을 클라이언트에게 보낸 후에 승인 번호를 보내줄 때까지 기다리는 `LAST_ACK` 상태에 들어간다.
<br>

### **STEP4 (Client => Server:ACK)**
#### 클라이언트는 FIN을 받고, 확인했다는 `ACK`를 서버에게 보낸다.
#### 아직 서버에게 받지 못한 데이터가 있을 수 있으므로, `TIME_WAIT`을 통해 기다린다. (실질적인 종료과정 `CLOSED`에 들어감)
#### 이떄 `TIME_WAIT`은 **의도치 않은 에러로 연결이 데드락으로 빠지는걸 방지한다.** 만약 에러로 인해 종료가 지연되면, 시간이 초과되어 `CLOSED`상태로 들어간다.
#### 서버는 ACK를 받은 후 소켓을 닫는다(Closed)
#### TIME_WAIT 시간이 끝나면 클라이언트도 닫는다(Closed)