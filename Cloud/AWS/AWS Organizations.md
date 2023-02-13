# **AWS Organizations**

<br>

### `AWS Organizations`는 **단일 조직을 생성**하고, **여러 AWS 계정을 이 조직으로 통합**하여 중앙에서 관리할 수 있는 무료 계정 관리 서비스이다.

<br>

### `AWS Organizations`에는 비즈니스에 필요한 예산, 보안과 규정 준수를 충족하는 데 도움이 되는 통합 결제 및 계정 관리 기능이 포함되어 있다.

<br>

![image](./../../Image/Cloud-AWS-Organizations.png)

<br><br>

---

<br>

## **AWS Organizations 주요 개념**

<br>

+ ### **Organization**

    `AWS Account`를 단윌 단위로 통합해 관리할 수 있는 개체이다. `Organization`안의 모든 계정을 중앙에서 확인하고 관리할 수 있으며, 여러 기능을 제공한다.  
    1개 이상의 `management account(payer account)와 0개 이상의 `member account(root account)`를 가지고 있다.  
    위의 그림에 나와있듯 tree 계층 구조로 `OU`를 생성할 수 있으며, 각 계정을 `OU`에 포함하거나 루트에 포함할 수 있다.

<br>

+ ### **Root**

    `Organization`에서 맨 위에 존재하는 폴더(컨테이너)이다.  
    루트에 정책을 적용하면 하위의 모든 `OU` 및 멤버 계정에 적용된다.

<br>

+ ### **OU(Organization Unit)**

    하위 그룹, 또는 sub 폴더와 같은 개념이다. `root`아래에 여러 `OU`를 포함할 수 있으며, `OU`는 하위에 또 다른 `OU`를 포함할 수 있다. 한 개의 계정은 한 개의 `OU`에만 속한다.

<br>

+ ### **Account**

    `AWS User`와 리소스를 가진 `AWS Account`를 말한다.  
    Account는 user를 말하는 게 아니며, `Organization` 안에는 두 개의 `account` 유형이 있다.  
    + #### management account(=payer account)
        계정생성/제거, 다른 계정을 조직에 초대, 조직 안 개체(Root, OU, Account...)에 정책을 적용할 수 있다. 또한, 모든 계정에서 발생하는 요금을 지불해야 하며, 관리계정은 변경될 수 없다.
    + #### member account(=root account)
        관리계정이 아닌 organization에 속한 모든 계정  
        하나의 AWS 계정은 하나의 organization 멤버만 될 수 있다.

<br>

+ ### **SCP(Service Control Policy)**

    Organization, OU, Account가 실행할 수 있는 권한


<br>

> `SCP` 또는 [IAM](./IAM.md)을 통해 보안에 활용할 수 있다.

<br><br>

---

<br>

## **Organizations의 기능**

<br>

+ ### AWS 계정을 중앙 집중하여 관리할 수 있다.

+ ### 모든 멤버 계정에 대해 통합 결제할 수 있다.

+ ### 예산, 보안, 규정 준수 충족을 위해 계정을 계층적으로 그룹핑 할 수 있다.

+ ### 정책을 중앙 집중 관리 할 수 있다.

+ ### 태그 관리 정책, 자동 백업 정책 등을 설정 할 수 있다.

<br>

> `AWS Organizations`는 아래와 같은 인터페이스를 통해 관리할 수 있다.  
> + AWS Management Console
> + AWS CLI
> + AWS SDK
> + AWS Organizations HTTPS Query API


<br><br>

