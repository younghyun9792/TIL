# **CloudTrail**

<br>

### `CloudTrail`이란 AWS 계정의 거버넌스, 규정 준수, 운영 감사, 위험 감사 등을 지원하는 서비스로 CloudTrail을 사용하면 AWS 인프라에서의 계정 활동과 관련된 작업을 기록하고 모니터링, 보관할 수 있다.

<br>

### 계정 내에서 이뤄진 활동이 CloudTrail 이벤트에 기록되고, AWS Console의 Event History에서 이벤트 기록을 확인할 수 있다.

<br>

> 이벤트 기록을 통해 계정 내에서 발생한 지난 **90일간의 활동을 확인**할 수 있다.

<br>

### 또한, 지정한 S3 Bucket에 이벤트를 저장할 수 있도록 구성되어 있고, CloudWatch Logs 및 Events를 통해 Trail의 이벤트를 전송 및 분석할 수 있다.


<br>
<br>

## **ClouTrail 작동 방식**

<br>

+ ### 모든 Region에 적용되는 Trail

    모든 Region에 적용되는 Trail을 생성 시, **CloudTrail은 각 Region에만 이벤트를 기록**한다.

    그리고, **CloudTrail 이벤트 로그 파일을 지정한 Amazon S3 Bucket으로 전송**한다.

    **새 Region을 추가할 경우, 해당 Region도 자동으로 포함되어 이벤트가 Logging**된다.(Console로 Trail 생성 시 Default 옵션)

<br>

+ ### **Region 하나에 적용되는 Trail**

    하나의 Region에 적용되는 Trail을 생성하면 CloudTrail은 해당 리전에만 이벤트를 기록한다.

    그 후, 지정한 S3 Bucket으로 CloudTrail 이벤트 로그파일을 전송한다.(AWS CLI, API를 사용 시 Default 옵션)

<br>

> 모범사례에 의하면 모든 리전에 적용되는 Trail을 생성할 것을 권장한다.

원하는 기간만큼 S3 Bucket에 Log파일을 저장할 수 있고, S3 수명 주기 규칙을 저의해 Log파일을 자동으로 보관/삭제할 수 있다.

<br><br>

- - -

<br>

## **CloduTrail Workflow**

<br>

+ ### 1. AWS 계정에 대한 이벤트 기록 확인

    AWS Console 혹은 AWS CLI를 통해 지난 90일간 기록된 이벤트를 확인 및 검색할 수 있다.

<br>

+ ### 2. 이벤트 다운로드

    지난 90일간 발생한 이벤트를 CSV, JSON 파일로 다운로드할 수 있다.

<br>

+ ### 3. Trail 생성

    CloudTrail은 Trail한 결과(Log 파일)를 S3 Bucket으로 전송할 수 있는데, AWS Console로 Trail을 생성하면 기본적으로 모든 Region에 Trail이 적용되고, AWS CLI나 API를 사용해 Trail을 생성하면 기본적으로 해당 리전에 대해서만 Trail이 적용된다.

<br>

+ ### 4. Amazon SNS Topic 생성 및 구독

    Amazon SNS Topic을 구독하면 Log 파일이 S3 Bucket으로 전송될 때 알림을 받을 수 있다. 다양한 방식으로 여러 상횡에 따른 알림을 받을 수 있다.

<br>

+ ### 5. 로그 파일 보기

    Amazon S3를 사용해 Log 파일을 확인 및 검색 할 수 있다.

<br>

+ ### 6. 사용자 권한 관리

    AWS IAM을 이용해 Trail을 생성, 구성, 삭제하거나 Logging의 시작과 종료, Log 파일이 포함된 Amazon S3 Bucket에 접근할 수 있는 AWS IAM 사용자를 관리할 수 있다.

<br>

+ ### 7. CloudWatch Logs를 이용한 이벤트 모니터링

    CloudTrail의 Log를 CloudWatch Logs로 전송해 Trail을 구성할 수 있다. 그 후, CloudWatch Logs를 이용해 AWS 계정에서 특정 API 호출 및 이벤트가 발생했는지 모니터링 할 수 있다.

<br>

+ ### 8. 관리 이벤트 및 데이터 업데이트 Logging

    읽기 전용, 쓰기 전용 혹은 모든 관리 이벤트와 데이터 이벤트를 Logging 하도록 Trail을 구성할 수 있다..

<br>

+ ### 9. CloudTrail insights 이벤트 Logging

    기록 관리 API 호출과 관련된 비정상적인 활동을 식별하고, 이에 대응할 수 있도록 Insight Event를 Logging하도록 Trail을 구성할 수 있다. Trail이 읽기 전용 또는 비관리 이벤트를 Logging하도록 구성되어 있으면, CloudTrail Insights 이벤트 Logging을 활성화할 수 없다.

    <br>

    > 기본적으로 Trail은 CloudTrail Insights Events를 Logging하지 않는다.

<br>

+ ### 10. Log 파일 암호화 활성화

    Log 파일 암호화는 Log 파일에 대한 추가 보안 계층을 설정하는 것이다. AWS KMS 관리형 키(SSE-KMS)로 Cloud Trail의 Log 파일을 암호화할 수 있다.

<br>

+ ### 11. Log 파일 무결성 활성화

    Log 파일 무결성 검증을 활성화 하는 것은 Log 파일이 CloudTrail에서 제공된 후 변경되지 않았음을 보장하는 데 도움이 된다.

<br>

+ ### 12. 다른 AWS 계정 간 Log 파일 공유

    AWS 계정 간에 Log 파일을 서로 공유할 수 있다.

<br>

+ ### 13. 여러 AWS 계정의 Log 파일을 취합

    여러 AWS 계정의 Log 파일을 단일 S3 Bucket에 취합할 수 있다.

<br><br>

---

<br>

## **CloudTrail에서 로깅할 수 있는 두 가지 유형의 이벤트**

<br>

+ ### **Management Events**

   **관리 이벤트는 AWS 계정의 Resource에 대해 수행되는 관리 작업에 대한 정보**를 말한다. 이를 제어 영역 작업, Control Plane Operations라고 부르기도 한다.

   보안 구성(IAM의 AttachRolePolicy API...), 디바이스 등록(Amazon EC2 CreateDefaultVPC API...), 데이터 라우팅 규칙 구성(Amazon EC2 CreateSubnet API...), 로깅 설정(AWS CloudTrail API...)등이 포함된다.

<br>

+ ### **Data Events**

   **데이터 이벤트는 Resource 상에서 혹은 Resource 내에서 수행되는 Resource 작업에 대한 정보**를 말한다. 이를 데이터 영역 작업이라고 한다.

   Amazon Se 객체 수준 API 활동(GetObject, DeleteObject, PutObject API...), AWS Lambda 함수 실행 활동(Invoke API...)등이 포함된다.

<br>

> **Trail을 생성 시 데이터 이벤트는 기본적으로 비활성화 된다. 해당 이벤트를 기록하려면 활동을 수집할 Resource 혹은 Resource 유형을 Trail에 명시적으로 추가**해야한다.

<br><br>

- - -

<br>

## **CloudTrail을 관리하는 방법**

<br>

+ ### **CloudTrail Console**

    AWS CloudTrail Console에서 CloudTrail 서비스를 사용 및 관리 할 수 있다.

    AWS Console은 AWS 계정의 최근 이벤트 및 이벤트 기록 보기, 지난 90일간의 이벤트에 대한 필터링된 파일이나 전체 파일 다운로드, CloudTrail 생성 및 편집 등을 위한 인터페이스를 제공한다.

<br>

+ ### **CloudTrail CLI**

    AWS Command Line Interface(CLI)는 명령줄에서 CloudTrail과 상호작용할 때 사용할 수 있는 도구이다.

<br>

+ ### **CloudTrail API**

    AWS Console, AWS CLI 이외에 CloduTrail RESTful API를 사용해 CloudTrail을 직접 프로그래밍할 수 있다.

<br>

+ ### **AWS SDK**

    CloudTrail API를 사용하는 대신 AWS SDK중 하나로 사용할 수 있다. 각 SDK는 다양한 프로그래밍 언어 및 플랫폼을 위한 라이브러리와 샘플 콛로 구성되어 있으며, AWS SDK를 활용하면 편리하게 CloduTrail에 프로그래밍 방식으로 접근할 수 있다.