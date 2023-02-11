# **CloudWatch**

<br>

### **`AWS CloudWatch`** 란 **AWS Resource**와 **AWS에서 실시간으로 실행 중인 애플리케이션**을 **모니터링하는 서비스**이다.

<br>

### 다양한 `Event`들을 수집하여 로그파일로 저장하며, 이벤트&알람 설정을 통해 SNS, AWS Lambda로 전송할 수 있다.

<br>

### 또한, AWS의 서비스를 이용하던 중 임계값을 위반/도달한 경우 모니터링 중인 리소스를 자동으로 변경하는 `Alarm`을 생성할 수 있다.

<br>

> 여기서 **`Event`** 란 S3 Bucket에 파일 업롣, 삭제, 접근 거부나 RDS에 접속 시도와 같이 **AWS서비스 내에서 이루어지는 환경의 변화**를 말한다.
> 
> **`Alarm`** 은 EC2 인스턴스 중지 및 Autoscaling 시작과 Amazon SNS를 통한 메세지 전송 등, **ClouWatch에 의해 감지되어 애플리케이션 및 리소스를 변경하고 알리는 것**이다.

<br><br>

---

<br>

## **ClouWatch 모니터링 종류**

<br>

+ ### **Basic Monitoring**

    **무료**이고, **5분 간격으로 최소한의 Metrics**를 제공한다.

<br>

> `Basic Monitoring`에서는, 기본적으로 **`Memory`** 항목이 없음.

<br>

+ ### **Detailed Monitoring**

    **유료**이고, **1분 간격으로 자세한 Metrics를 제공**한다.

<br><br>

---

<br>

## **ClouWatch에서 사용되는 용어들**

<br>

+ ### **Namespace**

    서비스를 논리적으로 구분하기 위한 값이다.
    예를 들어, `EC2 인스턴스의 CPU 점유율을 보고싶다`라고 하면, `EC2`가 `NameSpace`에 해당한다.

<br>

+ ### **Metric**

    `EC2 인스턴스의 CPU 점유율을 보고싶다`의 CPU 점유율처럼, **CloudWatch에 게시된 시간 순서별 데이터 요소의 집합**을 말한다. CloudWatch는 Region단위 서비스이므로, `Metric`는 **생성된 리전에만 존재**한다.

<br>

+ ### **Dimension**

    **Namespace에 대해 어떤 기준으로 Metric를 확인할 지**를 Dimension이라는 용어로 구분한다.

<br>

+ ### **Statics**

    `Dimension`을 선택하고 나면 `Metric`를 선택하고 `Metric 그래프`를 확인할 수 있는데, 이 때 발생된 이벤트들에 대한 지표를 **평균, 최소, 최대, 합계 등으로 확인**할 수 있다. 

    평균, 최소, 최대 합계 값 등 이런 통계 값들을 **`Statics`** 라고 한다.

<br>

+ ### **Period**

    또한, `Statics`를 정하고나서 1초, 5초, 10초, 30초, 1분, 5분, 1시간 등 다양한 시간 단위별로 지표를 확인할 수 있는데, 이를 **`Period`** 라고 한다.


<br>

> ### **지표 보존 기간**
> <br>
> 
> + #### 기간(Period)이 60초 미만으로 설정된 데이터 요소들은 3시간 동안 사용이 가능하다.
> + #### 기간(Period)이 60초(1분)으로 설정된 데이터 요소들은 15일 동안 사용이 가능하다.
> + #### 기간(Period)이 300초(5분)으로 설정된 데이터 요소들은 63일 동안 사용이 가능하다.
> + #### 기간(Period)이 3600초(1시간)으로 설정된 데이터 요소들은 15개월(455일) 동안 사용이 가능하다.

<br><br>

---

<br>

## **CloudWatch Agent**

<br>

EC2 인스턴스에 `CloudWatch Agent`를 설치하면, 더 많은 지표를 수집할 수 있다.

CloudWatch에서는 `Memory` 모니터링이 불가능하지만, CloudWatch Agent는 메모리를 모니터링해서 메모리 사용량을 볼 수 있다.

<br><br>