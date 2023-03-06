# FIN SCAN

<br>

`FIN SCAN`은 **스텔스 스캔**으로 TCP 헤더를 조작하여 스캔하는 대상에 로그를 남기지 않는다.

`NULL SCAN`, `X-MAS SCAN` 와 같은 성질(열려있으면 응답 없음, 닫혀있으면 `RST` 패킷이 돌아옴)을 가진다.

`FIN` 플래그만 설정하여 보낸다.

<br>


### 포트가 열려있을 때

![Image](./../../Image/../../Image/FINScan-Open.png)

<br>


### 포트가 닫혀있을 때

![Image](./../../Image/../../Image/FINScan-Closed.png)

<br>


<br>


# 실습

<br>


### 명령어

`nmap -sF -p 1-1023 192.168.64.1`

<br>


![Image](./../../../Image/FINScan-command.png)

<br>


### 분석파일

![Image](./../../Image/../../Image/FINScan-log.png)

위 사진처럼  `FIN` 플래그만 활성화된 상태로 보내는데, 포트가 활성화 되어있지 않으면 `RST, ACK` 응답이 온다.

`53(DNS)`는 활성화되어 있어서 `RST, ACK` 응답이 안 오는 걸 볼 수 있다.