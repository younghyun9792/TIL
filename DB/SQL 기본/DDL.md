# **DDL(Data Definition Language)**

<br>

## **테이블 관리 SQL문**
<br>

* ### **Create table**
  새로운 테이블을 생성하며, 생성할 때 기본키, 외래키, 제약사항 등을 설정할 수 있다.  
  <br>
* ### **Alter table**
  생성된 테이블을 변경하며, 컬럼을 추가하거나 삭제할 수 있고, 기본키나 외래키를 설정할 수 있다.  
  <br>
* ### **Drop table**
  헤딩 테이블을 삭제하는데, 해당 테이블의 구조 뿐만 아니라 저장된 데이터까지 모두 삭제한다.

<br>

```sql
Create Table EMP 
(
    empno   number(10)  primary key,
    ename   varchar2(20),
    sal     number(6)
);
```

<br>

* ### **Create Table EMP**
  'EMP"라는 테이블을 생성하며, ( );사이에 컬럼을 쓰고, 마지막은 세미콜론으로 끝낸다.  
  <br>
* ### **컬럼 정보(empno,emname,sal)**
  테이블에 생성되는 컬럼의 이릅과 데이터 타입을 입력하며, 컬럼 이름은 영문자로 작성한다.  
  <br>
* ### **데이터 타입(number,varchar...)**
  number는 숫자형 타입을, varchar2는 가변 길이 문자열, char는 고정된 크기의 문자, 날짜형 타입은 date를 사용한다.  
  <br>
* ### **기본키**
  기본키를 지정할 때는 컬럼 옆에 primary key를 입력한다.

<br><br>

> ### **테이블 구조 확인**
> 'DESC 테이블명'명령어로 테이블의 구조를 확인할 수 있다.

<br><br>

## **제약조건 사용**

<br>

```sql
Create Table EMP(
    empno   number(10),
    ename   varchar2(20),
    sal     number(10,2) default 0,
    deptno  varchar2(4) not null,
    createdate  date    default sysdate,
    constraint  emppk   primary key(empno)
);
```

<br>

* ### 아래 'constraint'를 사용하여 제약 조건 등을 지정할 수 있다.
* ### 만약 기본키가 두개라면 'constraint emppk primary key(empno,ename)' 이런 식으로 하면 된다.
* ### sal 컬럼은 number(10,2)인데, 이것은 소숫점 둘째 자리까지 저장하게 된다.
* ### Oracle 데이터베이스에서 'sysdate'는 오늘의 날짜를 조회하는데, default 옵션을 이용해서 오늘의 날짜를 기본 값으로 설정할 수 있다.
* ### 외래키(Foreign Key)를 지정하려면 마스터 테이블이 먼저 생성되어 있어야 한다.

<br>

```sql
constraint deptFk foreign key(deptno)
            references dept(deptno)
```
<br>

* ### 위에서 deptFk는 외래키 이름, foreign key(deptno)는 deptno컬럼을 외래키로 설정한 것이다.
* ### references dept(deptno)는 dept 테이블의 deptno를 참조하겠다는 뜻이다.
* ### 그리고, 테이블을 생성할 때 CASCADE 옵션을 사용하면 참조 관계가 있을 경우 참조되는 데이터도 자동으로 삭제할 수 있는 옵션이다.
  
<br>

```sql
Create Table EMP(
    empno   number(10),
    ename   varchar2(20),
    sal     number(10,2) default 0,
    deptno  varchar2(4) not null,
    createdate  date    default sysdate,
    constraint  e_k   primary key(empno),
    constraint  d_fk    foreign key(deptno)
                references dept(deptno),
                ON DELETE CASCADE
);
```
<br>

* ### 이렇게 하면, DEPT 테이블에서 EMP 테이블이 참조하는 데이터가 삭제되는 경우, 자동적으로 자기 자신도 삭제되는 옵션이다.
* ### ON DELETE CASCADE를 이용하여 참조 무결성을 준수할 수 있다.

<br><br><br>

## **테이블(Table) 변경**
<br>

* ### **테이블명 변경**  
```sql
ALTER TABLE EMP
    RENAME TO NEW_EMP;
```
<br>

* ### **컬럼 추가**

```sql
ALTER TABLE EMP
    ADD (age number(2) default 1);
```

<br>

* ### **컬럼 변경**

```sql
ALTER TABLE EMP
    MODIFY (ename varchar2(40) not null);
```

<br>

* ### **컬럼 삭제**

```sql
ALTER TABLE EMP
    DROP COLUMN age;
```

<br>

* ### **컬럼명 변경**

```sql
ALTER TABLE EMP
    RENAME COLUMN ename to new_ename;
```

<br><br><br>

## **테이블(Table) 삭제**

<br>

* ### 테이블 삭제는 DROP TABLE 문을 사용해서 삭제할 수 있는데, DROP TABLE은 테이블의 구조와 데이터 모두를 삭제한다.
```sql
DROP TABLE EMP;
```
<br>

* ### DROP TABLE에서 'CASCADE CONSTRAINT' 옵션을 사용하면 참조된 제약사항도 모두 삭제한다.
```sql
DROP TABLE EMP CASCADE CONSTRAINT;
```
<br><br><br>

## **뷰(View) 생성과 삭제**
<br>

* ### 뷰란 테이블로부터 유도된 **가상의 테이블**이다.
* ### 실제 데이터를 가지고 있지 않고, 테이블을 참조해서 원하는 컬럼만을 조회할 수 있게 한다.
* ### 뷰는 데이터 딕셔너리에 SQL문 형태로 저장하고 실행 시에 참조된다.

<br>

  ## 뷰의 특징

<br>

* ### 참조된 테이블이 변경되면 뷰도 변경됨
* ### 뷰의 검색은 테이블과 동일하나, 뷰에 대한 입력, 수정, 삭제에는 제약이 발생함.
* ### 특정 컬럼만 조회시켜서 보안성을 향상시킨다.
* ### 한번 생성된 뷰는 변경 불가능하며, 변경을 원할 시 삭제 후 재생성해야 한다.
* ### ALTER 문을 사용하여 뷰를 변경할 수 없다.

<br>

* * *

<br>

* ### 뷰의 생성
```sql
CREATE VIEW T_EMP AS
    SELECT * FROM EMP; -- SELECT 문을 사용하여 참조되는 테이블 지정
```

<br>

* ### 뷰의 조회
```sql
SELECT * FROM T_EMP;
```
<br>

* ### 뷰의 삭제
```sql
DROP VIEW T_EMP;
```

<br>

<br>

## **뷰의 장점과 단점**
<br>

* ### **장점**
  특정 컬럼만 조회할 수 있기 때문에 **보안 기능**이 있음. 
  **데이터 관리가 간단**해짐.
  **SELECT문이 간단해짐.**
  하나의 테이블에 여러 개의 뷰를 생성할 수 있음.

  <br>
* ### **단점**
  뷰는 독자적인 인덱스를 만들 수 없음.
  삽입, 수정, 삭제 연산이 제약됨.
  데이터 구조를 변경할 수는 없음.