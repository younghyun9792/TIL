# **System Manager**

<br>

### `AWS System Manager`는 하이브리드 클라우드환경을 위한 안전한 End to End 관리 솔루션이다.

<br>

### `EC2 System Manager` Ehsms `Simple Systems Manager(SSM)`으로도 알려진 `AWS System Manager`는, **AWS의 리소스 및 온프레미스 서버의 자동 및 수동 작업을 관리**한다.

<br><br>

---

<br>

## **AWS System Manager가 수행하는 업무**

<br>

+ ### 온프레미스 EC2 인스턴스의 패키지 업그레이드


+ ### 설치 소프트웨어 목록 생성

+ ### 새 애플리케이션 설치

+ ### EBS 스냅샷을 이용한 AMI 이미지 생성

+ ### IAM 인스턴스 프로파일 부착

+ ### S3 버킷에 대한 퍼블릭 접근 차단


<br><br>

---

<br>

## **Actions**

<br>

+ ### **Automation Action**

    AWS 리소스에 대한 작업을 수행한다.
    다수의 ETC 인스턴스 재시작, CloudFormation 스택 업데이트나 AMI 패치 등의 작업을 일괄적으로 할 수 있다.  
    개별 작업을 세분화 방식으로 처리 하거나 일괄적으로 전체 자동화 업무 처리, 단계적 처리 등을 할 수 있다.  
    자동화 액션은 한 번에 몇 개의 리소스를 처리 대상으로 삼을지 숫자나 퍼센트로 설정 할 수 있다.

<br>

+ ### **Command Action**

   Linux나 Windows 인스턴스에 대한 작업을 수행한다.  
   `Automation Action`이 AWS 리소스에 대한 작업 수행이라면 Run 명령은 대상 인스턴스에 대한 작업 수행이다.
   EC2 인스턴스에 설치된 에이전트를 통해 관련 작업을 수행한다.(Window Server, Amazon Linux, Ubuntu Server AMI 등에 기본적으로 설치돼있음)  
   대상은 태그로 필터링이나 개별 선택할 수 있고, 자동화 옵션 사용 시 한 번에 다중 인스턴스를 지정할 수 있다.

<br>

+ ### **Policy Action**

    관리 중인 인스턴스로부터 목록 데이터를 수집하는 과정을 정의한다.

<br>

+ ### **Session Manager**

    `Session Manager`는 보안 그룹, NACL에서 인바운드 포트를 개방하거나, 퍼블릭 서브넷에 인스턴스를 두지 않고도 Linux와 인스턴스에 대한 Bash 및 Powershell 접속을 지원한다.  
    Bation 설정 및 SSH 키 없이 다이렉트로 SSM을 통해 접속할 수 있으며, `Session Manager`를 사용한 연결은 TLS 1.2로 보호되며 모든 로그는 `CloudTrail`에 저장되고 세션에서 실행하는 모든 명령은 `S3 Bucket`에 저장된다.

<br>

+ ### **Patch Manager**

    `Patch Manager`는 Linux 및 Windows 인스턴스 패치 업무의 자동화 도구이다.  
    패치 대상 인스턴스는 태그 등을 기준으로 선택할 수 있으며, 패치 그룹을 생성하여 작업을 진행할 수 있다.(패치 그룹은 Patch Group 태그 키를 지닌 인스턴스 모음)  
    패치가 승인되면 설정한 유지보수 일정에 패치 작업이 진행되도록 하거나, 유지보수 일정이 도래하기 전에 즉각적으로 인스턴스에 대한 패치 작업을 실행할 수 있다. 패치 매니저는 패치 작업 수행을 위해 `AWS-RunPatchBaseline` Document를 실행한다.

<br>

+ ### **State Manager**

   `State Manager`는 인스턴스에 대해 일회성ㅇ로, 혹은 미리 정해진 일정에 따라 자동으로 명령 및 정책 Document를 실행한다.(인스턴스에 안티바이러스 소프트웨어를 설치한 뒤 관련 인벤토리를 가져오도록 하는 등)  
   `State Manager`를 실행하려면, 우선 실행할 명령 도큐먼트를 정의한 연계(Association) 객체를 생성한 뒤 전달할 파라미터, 타겟 인스턴스, 스케줄을 설정한다. 스테이트 매니저는 타겟 인스턴스에 대해 온라인으로 즉시 실행된 뒤 이후 스케줄에 따라 실행된다.  
   현재 스테이트 매니저와 함께 사용할 수 있는 정책 Document로 `AWS-Gather SoftwareInventory`가 있다. 이 Document는 인스턴스로부터 소프트웨어 인벤토리 등 특정 메타데이터를 수집하도록 하며, 여기엔 네트워크 환경설정, 파일 정보, CPU 정보 등이 포함된다.

<br>

> 패치 매니저가 인스턴스에 대해 동일한 패치 수준을 유지하도록 돕는 도구라면, 스테이트 매니저는 사용자가 정의한 방식대로 소프트웨어를 가져오고 환경을 설정하는 환경설정 도구라고 할 수 있다.



<br><br>

---

<br>

+ ## **Insights**

<br>

+ ### **Built-in Insight**

    `Built-in Insight`는 `System Manager`가 기본적으로 제공하는 모니터링 내역을 담고 있으며, 아래 내용을 포함한다.
    + AWS Config Compliance
    + CloudTrail Events
    + Personal Health Dashboard
    + Trusted Advisor Recommendations  

    모든 `Business and Enterprise` 지원 고객은 `Trusted Advisor` 확인 서비스에 접속할 수 있고, 모든 AWS 고객은 다음과 같은 보안 확인 서비스를 무료로 이용할 수 있다.  
    + S3 Bucket에 대한 public accessㅌ업롣, 삭제용 액세스 내역 등)
    + TCP Port 1443(MySQL), 3389(Remote Desktop Protocol) 등 당연히 접근 제한을 해야하지만 제한 없이 접근할 수 있는 포트 내역이 포함된 보안그룹
    + IAM 유저 생성 여부
    + 루트 유저를 위한 `MFA` 활성화 여부
    + [EBS](./EBS.md) 혹은 [RDS](./RDS.md) 스냅샷에 대한 퍼블릭 액세스

<br>

+ ### **Inventory Manager**

    `Inventory Manager`는 `OS`, `Application Version` 등 **인스턴스의 데이터를 수집**한다. 수집 내역은 아래와 같다.  
    + OS 이름 및 버전
    + 애플리케이션 및 파일네임, 버전, 사이즈
    + IP 및 MAC 주소 등 네트워크 환경설정
    + Windows 업데이트, 룰, 서비스, 레지스트리 값
    + CPU 모델, 코어, 스피드

<br>

+ ### **Compliance**

    `Compliance` 인사이트는 사용자가 정한 환경 설정 규칙이 인스턴스의 패치 및 상태 관리에 어떻게 적용되고 있는지 보여준다.  
    + **Patch Compliance**  
       패치 베이스라인이 적용된 인스턴스의 수 및 설치된 패치의 세부 정보를 보여준다.

    + **Association Compliance**  
        패치 작업이 성공적으로 실행된 인스턴스의 수를 보여준다.