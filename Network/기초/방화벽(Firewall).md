# **방화벽(Firewall)**

<br>



**방화벽(Firewall)** 이란 미리 정의된 보안 규칙에 기반해 들어오고 나가는 네트워크 트래픽을 모니터링하고 제어하는 **네트워크 보안 도구**이다.

<br>

일반적으로 **신뢰할 수 있는 내부 네트워크**와, **신뢰할 수 없는 외부 네트워크** 간의 장벽을 구성하여 서로 다른 네트워크를 지나는 데이터를 **허용, 거부, 검열, 수정**하는 등의 기능을 갖춘 소프트웨어나 하드웨어를 말한다.

<br>

![](https://velog.velcdn.com/images/younghyun/post/d3022c4a-f696-49e8-a43e-58beade50e11/image.png)

<br><br>

- - -

<br>

## **방화벽의 주요 기능**
<br>

### **접근 제어(Access Control)**
방화벽의 가장 기본적이고 중요한 기능으로 허용되지 않은 사용자의 접속을 차단한다.

<br>

### **사용자 인증(Authentication)**
방화벽은 내부, 외부 네트워크의 사이에 있기 때문에, 자신을 지나가는 트래픽에 대한 사용자들의 신분을 증명해야 한다.

<br>

### **감사 및 로그(Audting/Logging)**
방화벽은 모든 트래픽에 대해 접속 정보와 네트워크 사용에 따른 통계 정보를 기록한다.

<br>

### **주소변환(Network Address Translation)**
내부 네트워크에서 사용하고 있는 사설 IP를 공인 IP로 변환하여 공인 IP 주소 부족 문제를 해결하고, 내부 네트워크의 보안도 강화할 수 있다.


<br><br>

- - -

<br>

## **방화벽의 종류**

<br><br>

### **1. 패킷 필터링(Packet Filtering) 방식**  

<br>

가장 널리 사용되는 **기본적인 방법**으로, 인터넷과 내부 네트워크의 경계에 위치하여 **패킷의 정보를 확인해서 허용, 거부**한다.

<br>

![](https://velog.velcdn.com/images/younghyun/post/310420d2-d884-4f1e-aaf7-b14c61fb5588/image.png)

<br>

[`OSI 7계층`](OSI%207계층.md)의 네트워크 계층과 전송 계층에서 동작하며, 각 계층의 데이터를 바탕으로 **인바운드와 아웃바운드 서비스**를 제공한다.  

<br>

네트워크 계층에서 `IP`를, 전송 계층에서 `TCP`, `UDP` 여부와 `PORT` 번호를 얻어서, 해당 정보를 바탕으로 방화벽 정책을 세우고 정책에 맞게 패킷을 팰터링한다.

<br>

#### **장점**
다른 방화벽에 비해 속도가 빠르며, 비용이 적게 든다.  
하드웨어에 의존하지 않으며, 새로운 서비스에 쉽게 연동할 수 있다.
사용자에게 투명성을 제공한다.

<br>

#### **단점**
[`TCP/IP`](./TCP%EF%BC%8FIP%204%EA%B3%84%EC%B8%B5.md)의 구조상 패킷 헤더의 조작이 가능해서 필터링을 우회할 수 있다.  
또한, 패킷의 헤더가 아닌, 데이터에 대한 공격을 차단하지 못하여 악성 파일 전송 시 필터링할 수 없다.  
접근통제 리스트와, 순서에 따라 방화벽에 부하를 줄 수 있다.

<br><br>

### **애플리케이션 게이트웨이(Application Gateway)**

<br>

OSI 7 계층의 응용계층(Application Layer)까지 동작하며, 통과하는 패킷의 Header안의 Data 영역까지 체크한다.  

<br>

![](https://velog.velcdn.com/images/younghyun/post/9178204f-61e1-4bc1-9307-911abb8292ba/image.png)

<br>

[`Proxy`](./%ED%94%84%EB%A1%9D%EC%8B%9C(Proxy).md)  Daemon을 이용해 프로토콜별로 관리하고, 요청에 대해 **방화벽이 접근 규칙을 적용하고, 연결까지 대신 해준다.**  
이런 이유로 `Proxy Gateway`라고도 불린다.

<br>

>### **Daemon이란?**
>사용자가 직접적으로 제어하지 않고, `Background`에서 돌면서 여러 작업을 하는 프로그램

<br>

#### **장점**
Proxy를 이용해 IP가 노출되지 않아 보안성이 뛰어나다.  
[패킷 필터링(Packet Filtering)](#1-패킷-필터링packet-filtering-방식)보다 높은 보안 설정이 가능하다.  
애플리케이션 영역까지 동작하기에 `Logging`기능이 뛰어나다.


<br>

#### **단점**
Proxy를 이용하기 때문에, 요청이 한 단계 거쳐서 와서 성능이 약간 떨어질 수 있다.  
새로운 서비스를 제공하려면, 새로운 `Proxy Daemon`이 필요하기 때문에 새로운 서비스에 대한 유연성이 떨어진다.  
하드웨어에 의존적이다.

<br><br>

### **서킷 게이트웨이(Circuit Gateway)**

<br>

[OSI 7계층](./OSI%207%EA%B3%84%EC%B8%B5.md) 구조에서 **5계층(Session Layer)부터 7계층(Application Layer)사이에서 접근제어하는 방화벽**을 말한다.  

<br>

![](https://velog.velcdn.com/images/younghyun/post/baa3a44e-bccc-4081-a50c-26c6812080f1/image.png)

<br>

[`Application Gateway`](#애플리케이션-게이트웨이application-gateway)과는 다르게 서비스별로 새로운 Proxy가 존재하는 것이 아닌, 모든 서비스를 이용할 수 있는 **대표 프락시 하나만 둔다.**

<br>

`Curcuit Gateway`에서는 클라이언트 측에서 **Proxy를 인식할 수 있는 수정된 클라이언트 프로그램(Ex. SOCKS V5)이 필요**하다.

<br>

클라이언트 프로그램은 방화벽에 있는 대표 프락시와 연결을 맺고, 안전한 통신채널인 `Circuit`을 구성해 `Circuit`을 통해 내부 시스템과 통신을 한다.

<br>

#### **장점**
[Application Gateway](#애플리케이션-게이트웨이application-gateway)와 마찬가지로 IP를 숨길 수 있고, 관리가 더욱 수월하다.  
투명한 서비스를 제공한다.


<br>

#### **단점**
별도의 클라이언트 프로그램이 필요하다.  
지원 불가능한 프로토콜이 존재할 수 있다.  
`Application Gateway` 수준의 깊은 로깅, 감사 기능을 제공하지 않는다.

<br><br>



### **하이브리드(Hybrid) 방식**
<br>

[Packet Filtering](#1-패킷-필터링packet-filtering-방식)과 [Application Gateway](#애플리케이션-게이트웨이application-gateway) 방식을 혼합한 방법이다.

<br>

두 방식의 장점을 결합한 방식으로 **패킷 레벨의 접근 제어**뿐만 아니라, **응용 프로그램에서의 사용자 제어**도 할 수 있다.

<br>

대부분의 상용 방화벽이 `Hybrid` 방식을 채택한다.

<br>


#### **장점**
선택적인 보안 설정이 가능하다  
보안 설정 수준이 높고, 변경이 용이하다(Application Gateway)  
속도가 빠르고, 투명성을 제공한다(Packet Filtering)


<br>

#### **단점**
관리가 어렵고 복잡하다

<br><br>

### **상태추적(Stateful inspection) 방식**
<br>

[Packet Filtering](#1-패킷-필터링packet-filtering-방식)과 [Application Gateway](#애플리케이션-게이트웨이application-gateway) 방식의 단점을 보완하고 장점만을 구현한 방화벽이다.
<br>

2계층(DataLink Layer)과 3계층(Network Layer)에서 패킷들을 **상태정보 테이블**에 일정시간 저장하여 빠른속도로 처리하고 패킷 변조를 막을 수 있다.

<br>

리눅스의 iptables에서 사용하는 방식이며, 최근에 거의 모든 방화벽 시스템에서 채용되는 시스템이다.

<br>

#### **장점**
`Application Gateway`와 같은 성능저하가 발생되지 않으며 높은 필터링 기능을 제공한다.  
UDP, RPC 패킷도 추적이 가능하다.  
모든 통신 채널에 대해 추적이 가능하다.

<br>

#### **단점**
상태 테이블에 Dos, DDoS 등의 공격으로 인한 거짓 정보가 차게 되면 재가동해야 한다.  
