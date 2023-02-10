# **RDS**

<br>

### **`RDS(Relational Database Service)`** 란 **AWS에서 제공하는 관계형 데이터베이스**이다.

<br><br>

- - -

<br>

## **AWS에서 DB를 사용하는 방법**

<br>

+ ### **EC2에 직접 DB(Postgresql, oracle, mysql...)을 설치하는 방법**

    EC2에 직접 DB를 설치할 경우, 사용자가 DB의 업데이트와 관리, 백업 등을 모두 관리해야 한다.

<br>

+ ### **RDS를 이용하는 방법**

    EC2와 함께 RDS를 이용할 경우 더 많은 부분을 자동으로 관리할 수 있지만, 부가적인 요금이 발생한다.

<br><br>

---

<br>

## **RDS의 데이터베이스 엔진**

<br>

### 각각의 엔진마다 성능, 비용 등이 다르다.

<br>

+ Amazon Aurora


+ Amazon RDS for MySQL
+ Amazon RDS for Postgresql
+ Amazon RDS for MariaDB
+ Amazon RDS for Oracle
+ Amazon RDS for SQL Server

<br><br>

---

<br>

## **RDS의 장점**

<br>

+ ### **사용의 용이성**

    RDS를 이용하면 특정 DBMS 관리 도구를 공부할 필요 없이, 여러 인스턴스를 관리할 수 있다. 또한, 사용자에게 친숙한 DBMS 엔진과 호환되며, **자동으로 백업,  소프트웨어 패치 등을 해준다.**

<br>

+ ### **비용의 효율성**

    사용한 만큼만 비용을 지불한다. 또한, AWS RDS 예약 인스턴스를 이용하여 1~3년간 DB 인스턴스를 약정하여 사용하면, On-Demand 요금과 비교해 대폭 할인받을 수 있다.

<br>

+ ### **읽기 전용 복제본**

    읽기 전용 복제본을 사용하여, **읽기 작업이 많은 트래픽을 기본 DB 인스턴스에서 멀리 라우팅**하여 인스턴스의 작업 부하를 줄일 수 있다.

<br>

+ ### **다중 AZ 구성 배포**

    다중 AZ 구성으로, 현재 서비스되고 있는 RDS에 뭔가 문제가 생겨도 다른 AZ의 RDS로 빠르게 장애에 대응할 수 있다.

<br>

+ ### **관리 효율성**

    RDS는 추가 비용 없이 DB 인스턴스에 대한 `Amazon CloudWatch`와 연동해 지표를 제공하는데, RDS 관리 콘솔을 사용해 컴퓨팅/메모리/스토리지 용량 사용률, I/O 작업, 인스턴스 연결 등 주요 작업 지표를 보고 성능 문제를 신속하게 감지할 수 있는 편리한 도구인 성능 개선 도우미에 액세스할 수 있다.

<br><br>

---

<br>

## **RDS의 2가지 데이터 백업 기능**

<br>

+ ### **Automated Backup**

    RDS 생성 시 default로 설정되며, 백업 정보는 S3 버킷에 저장된다. RDS 스토리지만큼 S3 스토리지를 갖게 된다.

    Retention Period(1~35일) 안의 어떤 시간으로 돌아가게 할 수 있다. 또한, `Automated Backup`기간 동안, 약간의 I/O suspension이 생길 수 있다.(지연시간)

<br>

+ ### **DB Snapshots**

    주로 사용자에 의해 실행되며, **원본 RDS Instance를 삭제해도 스냅샷은 존재**한다.

    스냅샷만으로 RDS 인스턴스를 복원할 수 있지만, `Automated Backup`은 인스턴스 삭제 시 스냅샷이 모두 삭제된다.

    즉, RDS DB Snapshots 방식으로 백업 시, **새로운 RDS 인스턴스와 그에 해당하는 `RDS Endpoint`가 생기는 것**이다.

    `original.ap-northeast-2.rds.amazonws.com`, `restored.ap-northeast-2.rds.amazonws.com` 두 개의 객체는 완전히 다른 객체가 된다.

<br><br>

---

<br>

## **RDS 구성 아키텍쳐**

<br>

+ ### **Multi AZ**

    `Multi AZ`는 **두 개 이상의 AZ에 걸쳐 DB를 구축**하고, 원본과의 차이를 자동으로 동기화(Sync)하는 구조이다.

    메인 DB에 무언가 문제가 생기면, RDS는 이를 즉시 발견하고 다른 AZ의 복제본을 메인 DB로 승격시켜 그대로 사용하게 된다. 이를 `Disaster Recover`라고 한다.

<br>

+ ### **Read Replica**

    `Read Replica`는 DB를 복제하여, **메인 RDS DB에서 쓰기(Insert, Update...)작업**을 하고, **읽기(Read)는 복제본에서 처리하는 방식**이다.

    이렇게 읽기 전용으로 DB를 나누는 이뉴는, 서비스에서 Read작업이 많은 경우 `Read Replica`를 여러 개 만들어 효과적으로 부하를 분산시킬 수 있기 때문이다.

    `Read Replica`의 복제본들은 같은 AZ에 있을 수도 있고, 다른 AZ에 있을 수도, 다른 Region에 있을 수도 있는데 이 때문에 Multi AZ와는 다르게 **복제본 인스턴스에 DNS가 각각 부여**되어 접근 가능하다.

    이처럼 DB를 복제하여 쓰과, 읽기를 분별하여 트래픽을 분산하는 기술을 `Database Replication`이라고 한다.

<br>

+ ### **Multi Region**

    **다른 리전에 지속적으로 동기화 시키는 DB 클러스터를 생성**한다.

    다른 나라에서 접근할 때, Region이 멀리 있다면 지연시간이 있을 수 있다. **여러 Region에 읽기 전용 복제본을 둬서, Read 할 때 지연 시간을 줄일 수 있다.**
    
    Master Region에서는 데이터를 복제만 해주면 된다. 또한, `DR(Digaster Recovery)`를 위해서도 사용된다.

<br>

### **세 방식의 차이점**

<br>

+ #### **목적**

    `Multi-AZ`의 목적은 높은 가용성, `Multi-Region`의 목적은 DR(Digaster Recovery), 로컬 퍼포먼스(각 나라의 퍼포먼스), `Read Replica`의 목적은 성능이다.

<br>

+ #### **복제 방식**

     `Multi-AZ`의 복제방식은 `Sync(동기)`, `Multi-Region`와 `Read Replica`의 복제방식은 `Async(비동기)`이다.

<br>

+ #### **동작**

    `Multi-AZ`의 Primary DB만 읽기/쓰기가 가능하고 `Multi-Region`와 `Read Replica`은 Read만 가능하다.

<br>

+ #### **백업**

    `Multi-AZ`은 자동백업(Standby)이고, `Multi-Region`도 자동백업, `Read Replica`는 기본적으로 백업을 하지 않는다.

<br>

+ #### **엔진 업데이트**

    `Multi-AZ`는 Primary만 업데이트하고 `Multi-Region`는 Region별로, `Read Replica`는 DB별로 업데이트한다.

<br>

+ #### **FailOver**

    `Multi-AZ`는 자동으로 Standby로 Failober하고, `Multi-Region`와 `Read Replica`은 수동으로 Failover한다.

<br>

> ### FailOver란?
> 무언가 fail(실패)했을 떄 복구하는 과정이다.