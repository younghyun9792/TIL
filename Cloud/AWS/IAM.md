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
<br>
하나 이상의 Policy을 기반으로 구성된다.

+ **IAM 정책(Policy)**
IAM에서 권한을 부여하는 리소스이다.
<br>
IAM에는 아래와 같은 6가지 정책 유형이 있다.
    + 자격 증명 기반 정책
        <br>
        + Managed Policy
        <br>
        AWS에서 생성되고 관리되어져서 직접 Policy를 만들 필요가 없고, 다수의 User와 Group에 적용 가능하지만 수정하는 건 불가능하다.
    + 리소스 기반 정책
    + 사용 권한 경계(Permissions boundary)
    + Organizations SCP
    + 액세스 제어 목록(ACL)
    + 세션 정책


<br>

<br>

> ### **AWS의 사용자 유형**
> AWS에는 루트 사용자와 IAM 사용자가 있다.
> <br> **Root 사용자**는 최초로 AWS 계정 생성 시 전체 AWS 서비스, 리소스 등에 완전한 액세스 권한을 지닌 **단일 로그인 자격 증명(루트 사용자)** 로 시작하며, 모든 리소스에 대해 모든 액세스가 가능하다.
> <br> **IAM 사용자**는 사용자 별로 AWS 서비스, 또는 리소스 액세스에 제한을 둘 수 있는 사용자이다.

<br>
