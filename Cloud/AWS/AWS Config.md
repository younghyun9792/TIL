# **AWS Config**

<br>

### `AWS Config`란 AWS 계정에 있는 **AWS 리소스의 구성**과, **시간이 지나면서 구성과 관계가 어떻게 변했는지를 기록**하는 보안 및 거버넌스를 실현하는 서비스이다.

<br>

> `AWS Config`는 계정에 대해 Region별로 활성화된다.  
> 또한, [CloudTrail](./CloudTrail.md)과 연동할 수 있다.  
>  예를 들어 `Production-DB`보안 그룹이 잘못 구성되었을 경우 `AWS Config`를 이용해 보안 그룹이 잘못 구성되었음을 감지할 수 있고, [Cloud Trail](./CloudTrail.md)을 이용해 누가 보안 그룹을 잘못 구성했는지 찾아낼 수 있다.


<br><br>

---

<br>

## **AWS Config Rule**

<br>

### `AWS Config Rule`이란 원하는 리소스 구성을 말한다. `AWS Config`에서 기록한 관련 리소스의 구성 변경과 `AWS Config Rule`의 내용을 비교하여서, 대시보드에서 결과를 확인할 수 있다. 이를 통해 시간에 따른 규칙 준수 추세와, 리소스의 규축 미준수를 초래한 구성 변경이 무엇인지 찾을 수 있다.

<br>

### 또한, AWS Console -> AWS Config -> Conformance packs(적합성 팩) -> Deploy Conformance pack으로 가면 여러 Sample Template가 있는데, 이 템플릿들은 여러 공통 프레임워크 및 패키징 모델을 사용하여 구축된 구성 규칙 및 수정 조치 모음이다. 해당 템플릿을 사용하면 여러 계정 및 리전에서 거버너늣 정책 및 구성 규칙 준수의 배포 및 보고 특징을 단순화하고 자원이 규칙 미준수 상태인 시간을 줄일 수 있다.

<br>
<br>


