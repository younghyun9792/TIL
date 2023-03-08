# **nmap 사용법**

## **nmap이란?**

<br>

`nmap`이란 Gordon Lyon이 만든 스캐닝 툴로, 포트나 운영체제, 버전 등을 **스캐닝**할 때 쓰인다.

<br><br>

## 기본구조

<br>

`nmap [스캔 유형] [옵션] [호스트(ip)]`

  
기본 구조는 이런 식으로 이뤄져있다.

<br>

### 스캔 유형  
+ -sT : [TCP Full Open Scan](./../Network/공격%20기법/Scanning/TCP%20Full%20Open%20Scan.md)(TCP의 연결을 이용하여 포트를 스캔한다.)
+ -sS : [TCP Half Open Scan](./../Network/공격%20기법/Scanning/TCP%20Half%20Open%20Scan.md)(완전히 연결하지 않고, 연결이 되기 전에 확인하고 끊는 스텔스 스캔이다.)
+ -sP : Ping을 이용한 스캔이다.
+ -sA : [TCP ACK Scan](./../Network/공격%20기법/Scanning/TCP%20ACK%20Scan.md)(포트가 아닌, 방화벽의 룰셋등을 확인하기 위해 사용한다.)
+ -sU : [TCP UDP Scan](./../Network/공격%20기법/Scanning/UDP%20Scan.md)이다.(UDP 패킷을 이용한 스캔)
+ -sR : RPC를 이용해 포트를 스캔한다.
+ -sW : TCP ACK Scan과 같은데, 특정 장치에 대해 열린 장치, 닫힌 장치를 구별한다.
+ -sM : TCP Maimon 스캔이다. FIN 스캔과 비슷하게 동작한다.
+ -sX : [TCP X-mas Scan](./../Network/공격%20기법/Scanning/X-MAS%20SCAN.md)이다.
+ -sF : [TCP FIN Scan](./../Network/공격%20기법/Scanning/FIN%20Scan.md)이다.
+ -sN : [TCP NULL Scan](./../Network/공격%20기법/Scanning/NULL%20SCAN.md)이다.
+ -b : FTP bound Scan이다.
+ --scanflags \<flags> : 원하는 TCP 플래그를 지정하여 스캔할 수 있다.
+ -sO : IP Protocol Scan

<br><br>

---

<br>

### **포트 선택**
+ -p <포트번호> : 특정 포트 번호를 스캔한다. 포트 번호 대신 http, ssh 등 서비스 명이 올 수도 있다.
+ -p 22,53,80 : ,로 구분하여 여러 포트를 지정할 수 있다.
+ -p 20-80 : -를 이용해 포트의 범위를 지정할 수 있다.
+ -p- : 전채 범위를 스캔한다.
+ -p http* : 유사한 이름을 매치시키는 데에 와일드카드를 사용할 수 있다.(http, https...)
+ --exclude-ports \<port range> : 지정한 포트는 포트 스캔에서 제외하고 스캔한다.
+ -r : 포트를 랜덤 순서가 아닌 연속적으로 스캔한다.
+ --tcp-ports \<number> : 가장 자주 사용되는 포트를 number에 입력한 개수만큼 스캔한다.
+ --port-ratio \<ratio> : ratio 비율보다 자주 사용되는 포트를 스캔한다.(입력값은 0이상, 1미만이다.)

<br><br>

---

<br>

### **서비스/버전/운영체제 탐지**
+ -sV : 서비스/버전 정보를 열린 포트에서 조사한다.
+ --version-intensity \<level> : 0(light) 부터 9(try all probes)까지 조절할 수 있다. 낮으면 가능성이 농픈 것만, 높으면 모든 것을 다 시도한다.
+ --version-trace : 버전 스캔 활동을 자세히 표시한다(디버깅)
+ -O : OS 탐색을 허용한다.
+ --osscan-limit : 지정된 대상에게만 OS 탐색을 허용한다.
+ --osscan-guess, --fuzzy : 보다 자세한 OS 탐색기능을 제공한다.
+ --max-os-tries \<number>: OS 탐색 실패 시 재시도 횟수를 지정한다.

<br><br>

---

<br>

### **성능 옵션, 타이밍 조절**

<br>

+ -T[0~5] : nmap 스캔 속도를 T0(아주 느리게) 부터 T5(아주 빠르게) 까지 설정할 수 있다.
+ --min-rtt-timeout/max-rtt-timeout/initial-rtt-timeout \<time> : 프로브 왕복 시간을 조정한다.
+ --host-timeout \<time> : 입력한 time만큼의 시간이 지나면 타켓 스캔을 포기한다.
+ --scan-delay / --max-scan-delay \<time> : 프로브 간 대기시간을 조정한다.
+ --min-rate \<number> : 1초당 입력한 number보다 느리지 않게 패킷을 전송한다. 
+ --max-rate \<number> : 1초당 입력한 number보다 빠르지 않게 패킷을 전송한다.

<br><br>

---

<br>

### 방화벽,IDS 회피 및 스푸핑
+ -D \<decoy1, decoy2...> : 미끼(다른 ip)로 스캔을 숨긴다.
+ -S \<ip_address> : 출발지 주소를 스푸핑한다.
+ -e \<iface> : 지정된 인터페이스를 사용한다.
+ -g/--source-port \<portnum> : 지정한 포트번호를 사용한다.
+ --proxies \<url1, url2...> : HTTP/SOCKS4 프록시를 통한 릴레이를 연결한다.
+ --data \<hex string> : 보낸 패킷에 사용자 지정 페이로드를 추가한다.
+ --data-string \<string> : 보낸 패킷에 사용자 지정 ascii 문자열을 추가한다.
+ -ip-options \<options> : 지정된 Ip 옵션으로 패킷을 보낸다.
+ -ttl \<val> : IP TTL필드 설정
+ spoof-mac \<mac address/prefix/vendor name> : mac주소를 스푸핑한다.
+ badsum : 가짜 TCP/UDPSCTP 체크섬으로 패킷을 보낸다.

<br><br>

---

<br>

### **출력**
+ -v : nmap 스캔 진행 중에 스캔에 대해 더 많은 정보를 출력하게 하며, 열린 포트는 발견 됐다고 보여주고 추정 완료 시간을 제공한다.
+ -d : 디버깅 레벨을 증가시켜 nmap이 버그를 추적하는데 유용할 수 있는 옵션에 대해 상세한 사항을 출력하거나, 간단히 어떻게 작동하는지 출력하게 하는데 충분한 정보를 볼 수 없다면 -d5처럼 레벨을 붙여 더 자세한 사항을 볼 수 있다.
+ --packet-trace : nmap이 보내지거나 받은 모든 패킷의 요약을 출력한다.
+ -oN \<File name> : 파일명으로 지정한 파일에 nmap의 일반적인 결과를 저장한다. 대부분, 터미널에서 출력되는 표준 출력과 같다.
+ -oX \<File name> : 파일명으로 지정한 파일에 XML 형태로 출력 결과를 저장한다.
+ -oG \<File name> : 파일명으로 지정한 파일에 nmap의 `grepable` 형식으로 출력 결과를 저장한다. 다른 데이터로 grep, awk, sed하기 용이한 형태이다.
+ -oA \<File name> : 위의 세가지 형태를 각각의 파일명으로 출력한다.(Ex. test.nmap, test.xml, test.gnmap)
+ --open : nmap의 포트 테이블 중 열린 포트만 보여준다.
+ --append-output : 출력 결과를 덮어쓰지 않고 이어쓰고 싶을 때 사용한다.
+ --reason : 포트가 해당 상태인 이유를 출력한다.
+ --noninteractive : 백그라운드에서 nmap 실행 시, 터미널을 제어하는 것을 방지한다.