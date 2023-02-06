# **IAM**

<br>

### `IAM (Identity and Access Management)`이란 AWS의 기본적인 서비스 중 하나로, AWS 리소스에 대한 액세스를 안전하게 제어할 수 있는 서비스이다.

<br>

> ### **AWS에서의 리소스(Resource)**
> AWS에서는 컴퓨팅, 스토리지, 네트워크 등을 의미한다.

<br>

### **누가, 무엇을, 어떻게 할 것 인지**에 대해 인증과 인가를 제어하는 서비스이다.

![이미지](https://d1tlzifd8jdoy4.cloudfront.net/wp-content/uploads/2022/04/11-640x278.jpg)

<br><br>

---

<br>

## **IAM의 리소스**

<br>

`IAM`에서 관리하는 리소스는 크게 4가지로 나뉜다.
+ **IAM 사용자(Users)**

    IAM을 통해 IAM User를 생성할 수 있으며, Role과 Policy로 사용자의 권한을 조정할 수 있다.

<br>

+ **IAM 그룹(Groups)**

    User의 집합이다. Group단위로도 권한을 조정할 수 있다.

<br>

+ **IAM 역할(Roles)**

    Policy의 집합으로, 여러 개의 Policy를 합쳐 하나의 Role을 만들거나, Role과 Policy를 합쳐 하나의 Role로 만들 수도 있다.
하나 이상의 Policy을 기반으로 구성된다.
<br>

+ **IAM 정책(Policy)**

    IAM에서 권한을 부여하는 리소스이다.
<br>

<br>

> ### **AWS의 사용자 유형**
> AWS에는 루트 사용자와 IAM 사용자가 있다.
> <br> **Root 사용자**는 최초로 AWS 계정 생성 시 전체 AWS 서비스, 리소스 등에 완전한 액세스 권한을 지닌 **단일 로그인 자격 증명(루트 사용자)** 로 시작하며, 모든 리소스에 대해 모든 액세스가 가능하다.
> <br> **IAM 사용자**는 사용자 별로 AWS 서비스, 또는 리소스 액세스에 제한을 둘 수 있는 사용자이다.

<br>
<br>

- - -

<br>

## **IAM Policy**

<br>

IAM Policy는 아래와 같이 6가지로 분류된다.

+ 자격 증명 기반(Identity-based policies)
    + AWS 관리형 정책(AWS Managed Policy) - AWS에서 제공하는 글로벌 적용
    + AWS 고객 관리형 정책(AWS Customer Managed Policy) - 고객의 계정에서 생성해서 사용, 관리
    + AWS 인라인 정책(AWS Inline Policy) - 단일 사용자, 그룹, 역할에 직접 추가하는 방식 
+ 리소스 정책 기반(Resource-based policies)
+ 권한 경계 기반 정책(Permissions boundaries)
+ 조직 SCP 기반 정책(Organizations SCPs)
+ 액세스 제어 리스트(Access control lists, ACLS)
+ 세션 정책(Session policies)

<br>

### **IAM Policy 구조**
<br>

```
{
  "Statement":[{
    "Effect":"effect",
    "Action":"action",
    "Resource":"arn",
    "Condition":{
      "condition":{
        "key":"value"
        }
      }
    }
  ]
}

```

<br>

### Effect(효과)
`Allow` 혹은 `Deny`일 수 있다. 기본적으로, IAM 사용자에게는 리소스 및 API 작업을 사용할 권항니 없으므로 모든 요청이 거부되며, 명시적 허용은 기본 설정을 무시한다.
명시적 거부는 모든 허용을 무시한다.
<br>

### Action
action은 권한을 부여하거나, 거부할 **특정 API 작업이다.**

<br>

### Resource(리소스)
작업에 영향을 받는 특정 리소스를 의미한다.

<br>

### Condition(조건)
Condition은 선택사항으로, 정책이 적용되는 시점을 제어하는 데 사용할 수 있다.

<br><br>

---
<br>

## **IAM의 주요 기능**
<br>

+ 계정에 대한 공유 액세스

    암호나 액세스 키를 공유하지 않아도 AWS의 계정의 리소스를 관리, 사용할 수 있는 권한을 다른 사람에게 부여할 수 있다.

<br>

+ 세분화된 권한

    리소스에 따라 여러 사람 또는 EC2 인스턴스에서 실행되는 애플리케이션에 안전하게 제공된다.

<br>

+ 멀티 팩터 인증(MFA)

    계정 작업을 위해 암호나 액세스 키뿐 아니라, 특별히 구성된 디바이스 코드도 제공된다.

<br>

+ 자격 증명 연동

    기업 네트워크나 인터넷 자격 증명 공급자와 같은 다른 곳에 이미 암호가 있는 사용자에게 AWS 계정에 대한 임시 액세스 권한을 부여할 수 있다.

<br>

+ IAM 엑세스 방식

    AWS Management Console, AWS 명령줄 도구(CLI, WIndow용 PowerShell), AWS SDK, IAM HTTPS API

<br><br>

---

<br>

## **IAM 특징**
<br>

+ 접근키(Access Key), 비밀키(Secret Access Key)

    터미널 혹은 API를 통하여 접근키와 비밀키를 가지고 AWS 서비스를 원격에서 사용 가능하다.

<br>

+ 디테일한 접근 권한 부여 기능

    개별 IAM 유저별로 다르게 권한을 부여 가능하다.

<br>

+ 비밀번호를 수시로 변경 가능

    각 유저마다 보안을 위해 한달, 혹은 분기별로 AWS 사용자들의 비밀번호를 일괄적으로 업데이트 설정 할 수 있다.

<br>

+ 다중 인증 기능(MFA)

    AWS 외부 계정읋 통해 사용자 인증을 요구하기에 보안 강화가 가능하다.

<br>

+ 유니버셜(Universal)

    IAM은 지역 연결이 필요하지 않고 유니버셜하다.