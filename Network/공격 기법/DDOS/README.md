# **DDoS란?**

### `DDoS (Distributed Denial of Service)`란 **다수의 악의적인 사용자**가 특정 사이트에 동시에 접속하여 **과도한 트래픽**을 일으켜 **정상적인 서비스를 방해**하는 공격이다.
### DDos의 공격 유형으로는, 대역폭 공격, 프로토콜 공격, 애플리케이션 3가지 유형이 있다.

<br>

## **대역폭 공격**
해당 공격은 다수의 좀비 PC에서 대용량 트래픽을 일으켜 해당 서버의 네트워크 대역폭을 소진시킨다.

+ UDP Flooding
+ ICMP Flooding

<br>

## **프로토콜 공격**
해당 공격은 IP계층이나 전송 계층 프로토콜들의 구조적인 취약점을 악용해 대상 서버나 경로상에 있는 네트워크 장비(라우터, 방화벽, 스위치...)의 자원을 소진시킨다.

+ [TCP SYN Flooding](TCP%20SYN%20Flooding.md)
+ TCP Out-of-State-Packet Flooding
+ Ping of Death

<br>

## **애플리케이션 공격**
해당 공격은 애플리케이션의 구조적인 취약점이나 운영체제의 보안 취약점을 악용하여 대상 서버의 자원을 소진시킨다.

+ HTTP GET Flooding
+ CC Attack
+ Slowloris
+ RUDY
+ DNS Query Flooding
+ DNS Amplication DDoS
+ Mail Bomb
