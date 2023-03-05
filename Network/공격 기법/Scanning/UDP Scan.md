# UDP Scan

<br>

`UDP Scan` 은 `UDP` 패킷을 전송해 응답이 안 오면 응답이 없고, `ICMP Unreachable` 이 오면 포트가 닫혀 있는 상태이다.

<br>


### 포트가 열려있을 때

![Image](./../../Image/../../Image/UDPScan-Open.png)

<br>


### 포트가 닫혀있을 때

![Image](./../../Image/../../Image/UDPScan-Closed.png)

<br>


## 장점

- 속도가 빠르다

<br>


## 단점

- 방화벽에 의해 차단당할 수 있다.

<br>


# 실습

<br>


### 명령어

`nmap -sU -p 1-1023 192.168.64.1`

<br>


### 포트가 닫혀있을 때

![Image](./../../Image/../../Image/UDPScan-log-Closed.png)

위 사진처럼 포트가 닫혀 있으면 `UDP` 패킷을 보내고, `ICMP Destination Unreachable` 메시지가 온다.

<br>


### 포트가 열려있을 때

![Image](./../../Image/../../Image/UDPScan-log-open.png)

포트가 열려있으면 위 사진의 547번 포트처럼 `ICMP Destination Unreachable` 메시지가 오지 않고, 여러 번 확인한다.