# **Firewall Manager**

<br>

### `Firewall Manager`란 방화벽 규칙을 중앙에서 구성 및 관리할 수 있는 보안 관리 서비스로, [Organization](./AWS%20Organizations.md) 안의 `account` 및 `app`에 적용된다.

<br><br>

---

<br>

## **Firewall Manager의 기능**

<br>

+ ### `Application Load Balancer`, `API Gateway` 및 `CloudFront` 배포에 대해 [AWS WAF](WAF.md) 규칙을 쉽게 적용시킬 수 있다.

+ ### `Application Load Balancer`, `ELB Classic LoadBalancer`, 탄력적 IP 주소 및 `CloudFront` 배포에 대한 [AWS Shield](Shield.md) Advanced 보호를 생성할 수 있다.

+ ### [VPC](VPC.md) 보안 그룹을 구성하고, EC2, ALB 및 ENI 리소스 유형에 대해 기존 VPC 보안 그룹을 감사할 수 있다.

+ ### 조직 내 계정과 VPC에 [AWS Network Firewall](Network%20Firewall.md)를 배포할 수 있다.

+ ### VPC를 `Amazon Route 53 Resolvers DNS` 방화벽 규칙과 연결할 수도 있다.

<br>

![image](../../Image/Cloud-AWS-FIrewall%20Manager.png)

<br>
<br>

---

<br>

## **장점**

<br>

+ ### 여러 계정에서 방화벽 규칙 관리 간소화

+ ### 기존 및 새로운 애플리케이션의 규정 준수 보장

+ ### 여러 계정에서 관리형 규칙 손쉽게 배포

+ ### VPC에 대한 보호를 중앙에서 배포

<br>

> `Firewall Manager`를 적용하면 `Organization` 안의 모든 account, user, resource가 영향을 받으므로, 특정 그룹만을 위해 `Firewall Manager`를 도입하긴 어렵다.  
> 이런 경우, 새로운 Organization을 만들어야 한다.