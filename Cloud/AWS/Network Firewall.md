# **Network Firewall**

<br>

### `AWS Network Firewall`이란 말 그대로 네트워크를 보호하는 방화벽으로, **[VPC](./VPC.md) 기반 관리형 방화벽 서비스**이다.

<br>

![image](../../Image/Cloud-AWS-Network%20Firewall.png)

<br>

> ### 위 사진처럼 [VPC](./VPC.md)안에 `Network Firewall`과 통하는 `Firewall endpoint`를 놓고, `Internet Gateway`를 통해 **들어오고 나가는 트래픽을 Rule을 통해 필터링하여 인스턴스를 보호**한다.

<br><br>

---

<br>

## **Network Firewall**의 특징

<br>

+ ### Inbound 뿐만 아니라 **Outbound 트래픽**까지 감시가 가능하다.

+ ### IPS 엔진을 통해 **IPS Rule 기반(패턴 매칭 방식)의 `Layer 7`** 통제와 감시가 가능하다.

+ ### FQDN(도메인 기반) 형태의 웹 필터링과 감시가 가능하다.

+ ### **다수의 서브넷이나 VPC 단위** 및, **Direct Conenct나 VPN과 연결 지점**에서 통제와 감시가 가능하다.
