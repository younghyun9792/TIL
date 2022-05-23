# **테이블 파티션(Table Partition)**

<br>

## **Partition 기능**

<br>

* ### 파티션은 대용량의 테이블을 여러 개의 데이터 파일에 분리하여 저장한다.

<br>

* ### 테이블의 데이터가 물리적으로 분리된 데이터 파일에 저장되면 입력, 수정, 삭제, 조회 성능이 향상된다.

<br>

* ### 파티션은 각각의 파티션 별로 독립적으로 관리될 수 있다. 즉, 파티션 별로 백업하고 복구가 가능하면 파티션 전용 인덱스 생성도 가능하다.

<br>

* ### 데이터를 조회할 때 데이터의 범위를 줄여서 성능을 향상시킨다.

<br><br>

## **Range Partition**

<br>

* ### Range Partition은 테이블의 컬럼 중에서 값의 범위를 기준으로 여러 개의 파티션으로 데이터를 나누어 저장하는 것이다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/45e2fc6d-8188-42cf-95b0-ba5a0a83d17f/image.png)

<br>

* ### 위의 예에서는 SAL 값 2000~4000은 Datafile1.dbf 파일에 저장하고 SAL 값 5000~7000의 값은 Dafafile2.dbf에 저장한다.

<br><br>

## **List Partition**

<br>

* ### List Partition은 특정 값을 기준으로 분할하는 방법이다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/2843803c-cdde-414b-9090-504fd64f9542/image.png)

<br>

* ### 위의 예에서 DEPTNO가 10번인 것은 Datafile1.dbf에 저장하고 DEPTNO가 20번인 것은 Datafile2.dbf에 저장한다.

<br><br>

## **Hash Partition**

<br>

* ### Hash Partition은 DBMS가 내부적으로 해시함수를 사용해서 데이터를 분할한다.

<br>

* ### 결과적으로 DBMS가 알아서 분할하고 관리하는 것이다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/48f57261-b6c6-4d8e-86e4-51a50cfc8abd/image.png)

<br>

* ### Hash Partition 이외에도 Composite Partition이 있는데, Composite Partition은 여러 개의 파티션 기법을 조합해서 사용하는 것이다.

<br><br>

## **파티션 인덱스**

<br>

* ### 파티션 인덱스는 4가지 유형의 인덱스를 제공한다. 즉, 파티션 키를 사용해서 인덱스를 만드는 Prefixed Index와 해당 파티션만 사용하는 Local Index 등으로 나누어진다.

<br>

* ### Oracle DBMS는 Global Non-Prefixed를 지원하지 않는다.

<br>

* ### 파티션 인덱스(Partition Index)

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/23395fd8-3c50-4a9a-8fe3-7a0cbf41a4d5/image.png)