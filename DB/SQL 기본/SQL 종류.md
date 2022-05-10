# **SQL(Structured Query Language) 종류**
<br>

## SQL(Structured Query Language)
  
<br>

* ### SQL은 관계형 데이터베이스에 대해서 **데이터의 구조를 정의, 데이터 조작, 데이터 제어 등을 할 수 있는 절차형 언어이다.**
* ### 관계형 데이터베이스는 데이터베이스를 연결하고 SQL문을 사용하여 데이터베이스를 누구나 쉽게 사용할 수 있도록 해준다.
* ### SQL은 ANSI/ISO 표준을 준수하기 때문에 DBMS가 변경되어도 그대로 사용할 수 있다.

<br>

## SQL 표준
> ### **ANSI/ISO SQL 표준** 
>  INNER JOIN, NATURAL JOIN, USING 조건 ON 조건절을 사용한다.
> ### **ANSI/ISO SQL3 표준**
>  DBMS 벤더별로 차이가 있었던, SQL을 표준화하여 제정한다.

<br><br><br>

## **SQL 종류**

<br>

* ### **DDL(Data Definition Language), 데이터 정의어**
  관계형 데이터베이스의 구조를 정의하는 언어로, Create, Alter, Drop 문 등이 있다.  
  <br>
* ### **DML(Data Manipulation Language), 데이터 조작어**
  테이블에서 데이터를 입력, 수정, 삭제, 조회 등을 하며 Insert, Update, Delete, Select 문 등이 있다.  
  <br>
* ### **DCL(Data Control Language), 데이터 제어어**
  데이터베이스의 사용자에게 권한을 부여하거나 회수하며, Grant, Revoke 문 등이 있다.  
  <br>

![이미지](https://velog.velcdn.com/images/as979200/post/de03e27c-4f6f-48cb-b56e-14951c158fd4/image.png)

  <br>

* ### **TCL(Transaction Control Language), 트랜잭션 제어어**
  트랜잭션을 제어하는 명령어로, Commit, Rollback 문 등이 있다.

<br>

> ### **트랜잭션이란?**
> 트랜잭션은 데이터베이스의 작업을 처리하는 단위이다.

<br>

## **트랜잭션의 특성**
  <br>

* ### 원자성(Atomicity)
  * 트랜잭션에서 정의된 연산들은 모두 성공적으로 실행되던지, 아니면 전혀 실행되지 않은 상태로 남아 있어야 한다. (ALL OR NOTHING)  
  * 트랜잭션 내의 모든 명령은 완벽히 수행되어야 하는데, 만약 어느 하나라도 오류가 발생하면 트랜잭션 전부가 취소되어야 한다.
  <br>
* ### 일관성(Consistency)
  * 트랜잭션이 그 실행을 성공적으로 완료하면 언제나 일관성 있는 데이터베이스 상태로 변환한다.
  * 시스템이 가지고 있는 고정요소는 트랜잭션 수행 전과 트랜잭션 수행 완료 후의 상태가 같아야 한다.  
  <br>
* ### 고립성(Isolation)
  * 트랜잭션이 실행 중에 생성하는 연산의 중간결과는 다른 트랜잭션이 접근할 수 없다.
  * 즉, 부분적인 실행 결과를 다른 트랜잭션이 볼 수 없다.  
  <br>
* ### 연속성(Durability)
  * 트랜잭션이 그 실행을 성공적으로 완료하면 그 결과는 영원히 반영되어야 한다.

<br><br><br>

## **SQL문의 실행 순서**

<br>

## 1. 파싱(Parsing)
* ### SQL 문의 문법을 확인하고, 구문을 분석한다.
* ### 구문분석한 SQL은 Library Cache에 저장한다.  
<br>

## 2. 실행(Execution)
* ### 옵티마이저(Optimizer)가 수립한 실행 계획에 따라 SQL을 실행한다.  
<br>


>### **옵티마이저란**?
> 옵티마이저는 가장 효율적인 방법으로 SQL을 실행할 최적의 처리 경로를 생성해주는 DBMS의 핵심 엔진이다.

<br>

## 3. 인출(Fetch)
* ### 데이터를 읽어서 전송한다.

<br><br>