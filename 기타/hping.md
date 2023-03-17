# hping

hping은 네트워크에 존재하는 서버, PC, 네트워크 장비 등이 살아 있는지 확인하기 위해 사용하는 ping 명령어보다 다양한 기능을 제공하는 툴이다.

hping 명령어를 이용해 네트워크 환경을 분석하거나, 공격할 수 있는 공격 도구이자 분석도구이다.

현재는 hping3 버전이 쓰인다.

<br><br>

### 기본 구조

`hping3 [옵션] 목적지ip`

<br>

## 프로토콜

- `-0`, `--rawip` : RAW IP 모드
- `-1`, `--icmp` : ICMP 모드
- `-2`, `--udp` : UDP 모드
- `-8`, `--scan` : SCNA 모드

<br>


<br>


## 옵션

- `-h`, `--help` : 설명
- `-v`, `--version` : 버전
- `-c`, `--count` : 패킷의 수를 보여준다.
- `-i`, `--interval` : 패킷의 수를 조절한다. `-i u1000` 이런 식으로 사용하며, u1000은 1000microseconds마다 1개의 패킷(초당 100개의 패킷)을 보낸다는 뜻이다.
- `--fast` : `-i u10000` 의 줄임말로, 1초당 10개의 패킷을 보낸다.
- `--faster` : `-i u1000`의 줄임말로, 1초당 100개의 패킷을 보낸다.
- `--flood` : 가능한 가장 빠른 속도로 패킷을 보낸다.
- `-I`, `--interface` : 인터페이스 이름을 지정한다.
- `-D`, `--debug` : 디버깅 정보를 나타낸다.
- `-d`, `--data` : 패킷 크기를 설정한다.
- `-E`, `file` : 파일로부터 데이터를 설정한다.
- `-T`, `--traceroute` : traceroute 모드로 설정한다.

<br>


<br>


## UDP/TCP 옵션

- `-s`, `--baseport` : source port를 정한다.(기본적으로 random값)
- `-p`, `--destport` : destination port를 정한다.(기본적으로 0)
- `-w`, `--win` : winsize를 정한다.(기본적으로 64)
- `-O`, `--tcpoff` : tcp data offset을 조작한다.
- `-b`, `--badchsum` : IP checksum 값을 조작하여 보낸다.
- `-M`, `--setseq` : TCP sequence number를 설정한다.
- `-F`, `--fin` : TCP FIN flag를 설정한다.
- `-R`, `--rst` : TCP RST flag를 설정한다.
- `-S`, `--syn` : TCP SYN flag를 설정한다.
- `-P`, `--push` : TCP PUSH flag를 설정한다.
- `-A`, `--ack` : TCP ACK flag를 설정한다.
- `-U`, `--urg` : TCP URG flag를 설정한다.

<br>


<br>


## IP 프로토콜 옵션

- `-a`, `--spoof` : source address를 spoofing한다.
- `-t`, `--ttl` : ttl을 설정한다.(기본적으로 64)
- `-N`, `--id` : Ip id를 설정한다.(기본적으로 random)
- `-m`, `--mtu` : virtual mtu를 설정한다.
- `-o`, `--tos` : type of service(기본적으로 0)을 설정한다.