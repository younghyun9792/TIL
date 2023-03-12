# ARP Redirect

<br>

`ARP Redirect`란 `ARP Spoofing`과 비슷한 공격으로, 라우터의 `MAC` 주소를 알아내어 자신이 라우터라고 주기적으로 위조된 `ARP Reply` 패킷을 브로드캐스트하여, 자신을 라우터라고 속이게 된다.

이렇게 하고 패킷을 `Relay` 해주면, 통신이 정상적으로 진행되는 것처럼 보이지만 모든 
패킷은 라우터라고 생각하고 있는 `ATTACKER` 를 통해서 나가게 된다.

<br><br>

---

<br>

## ARP Spoofing과의 비교



- ARP Spoofing 공격은 호스트 대 호스트 공격이며, ARP Redirect는 랜의 모든 호스트 대 라우터이다.
- 그 외에는 큰 차이점이 없으며, ARP Redirect 또한 원래 라우터의 MAC 주소를 알아야 하고 다시 라우터로 `Relay` 해 주어야 한다.

<br><br>

## 대응 방안

- `ARP Spoofing`과 같이 대응한다. (정적 MAC 설정…)