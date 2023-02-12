# **Audit Manager**

<br>

### `AWS Audit Manager`는 AWS 사용량을 지속적으로 감사하여 위험 및 규정 준수 평가를 간소화할 수 있다.

<br>

### 또한, 공통 산업 표준 및 규정에 매핑된 제어, 프레임워크 및 제어의 전체 사용자 지정, 각 제어 요구 사항에 정의된 대로 AWS의 사용에서 증거의 자동 수집 및, 구성을 포함하는 **사전 구축된 프레임워크를 제공**한다.

<br>

### 감사 시간이 되면 AWS Audit Manager를 통해 통제 항목에 대한 이해관계자의 검토를 관리함으로써 수동 작업을 대폭 줄이면서 감사 준비 보고서를 작성할 수 있다.

<br><br>

---

<br>

## **사전 구축된 프레임워크의 예**

<br>

+ ### AWS Control Tower

+ ### AWS License Manager

+ ### CIS AWS Foundations Benchmark 1.2.0, 1.3.0

+ ### CIS Controls v7.1 Implementation Group1

+ ### FedRAMP Moderate

+ ### 일반 데이터 보호 규정(GDPR)

+ ### GxP 21 CFR 제11부

+ ### 건강보험의 양도 및 책임에 관한 법률(HIPAA)

+ ### 지불 카드 보안 표준(PCI DSS) v3.2.1

+ ### Service Organization Control 2(SOC2)

+ ### NIST 800-53(rev 5)

<br>

> 또는, 사용자가 Audit Manager를 사용해 자체 프레임워크를 구축할 수 있다.  
> Audit Manager를 사용하면 특정 비즈니스 요구 사항을 준수하기 위해 기존 프레임워크의 제어를 평가하는 데 도움이 된다.


<br><br>

---

<br>

## **자동화된 증거 수집**


<br>

### 평가가 정의되고 시작되면 `AWS Audit Manager`는 감사 범위에 포함되도록 정의한 AWS 계정 및 서비스에 대한 데이터를 자동으로 수집한다.

<br>

### 증거에는 해당 리소스에서 캡처한 데이터와 보안, 변경 관리, 비즈니스 연속성 및 소프트웨어 라이센스 준수를 입증하는 데 도움이 되는 데이터가 지원하는 제어를 나타내는 메타데이터가 모두 포함되는데, [AWS CloudTrail](CloudTrail.md) 및 `AWS Config`, `AWS Secutiry Hub` 및 `AWS License Manager`와 같이 사용 중인 기타 AWS 서비스에서 증거를 수집하고 구성한다.

<br>

> 또한, `AWS Audit Manager`는 `AWS Organizations`와의 통합을 통해 여러 계정을 지원한다.  
> Audit Manager 평가는 여러 계정에서 실행될 수 있으며, 증거를 수집하여 `AWS Organizations`의 위임된 관리자 계정으로 통합한다.