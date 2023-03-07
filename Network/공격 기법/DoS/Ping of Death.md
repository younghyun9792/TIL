# Ping of Death

<br>

`Ping of Death`란 정상적인 크기 이상의 `ICMP` 패킷으로 시스템을 마비시키는 공격이다.

크기가 큰 패킷을 전송하게 되면, `IP` 프로토콜에 따라 전송될 때 일정 크기 단위로 `단편화(Fragmetation)`되어 전송되는데, 분할된 수많은 패킷으로 과부하를 주는 공격이다.

<br><br>

---

<br>

# 실습

<br>

## 명령어

`hping3 192.168.64.1 -d 30000 --flood`

<br>

## 공격 로그

![Image](./../../Image/../../Image/Ping%20of%20Death-log.png)

크기가 30000바이트인 `TCP` 패킷이 위 사진처럼 `Fragmented IP protocol` 메시지와 함꼐 여러 개의 패킷으로 분할되어서 온 것을 볼 수 있다.

<br>

## 대응 방법

- ICMP 프로토콜에 대해 응답을 하지 않는다.