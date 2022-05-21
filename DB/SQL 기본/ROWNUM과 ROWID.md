# **ROWNUM과 ROWID**

<br>
<br>

## **ROWNUM**

<br>

* ### ROWNUM은 SELECT문의 결과에 대해서 논리적인 일렬번호를 부여한다.

<br>

* ### ROWNUM은 조회되는 행 수를 행 수를 제한할 때 많이 사용된다.

<br>

* ### ROWNUM을 사용해서 한 개의 행을 가지고 올 수 있으나, 여러 개의 행을 가지고 올 때는 인라인 뷰(Inline View)를 사용해야 한다.

<br>

```sql
SELECT * FROM EMP
WHERE ROWNUM <= 1;
```
* ### 한 행을 조회한다.

<br>

```sql
SELECT *
FROM (SELECT ROWNUM list, ENAME FROM EMP) -- FROM절에 SELECT절(Inline View)를 사용한다. ROWNUM에 별칭(Alias)를 사용하여 list라고 부른다.
WHERE list <= 5; --5건의 행을 조회한다.
```
* ### 5건의 행을 조회하기 위해서는 인라인 뷰를 사용하고 ROWNUM에 별칭을 사용해야 한다.

<br>

```sql
SELECT *
FROM ( SELECT ROWNUM list, ENAME FROM EMP)
WHERE list BETWEEN 5 and 10;
```
* ### 위의 예처럼 ROWNUM과 BETWEEN구를 사용하여 웹 페이지 구현을 구현할 수 있다.

<br><br>

## **ROWID**

<br>

* ### ROWID는 ORACLE DB내에서 데이터를 구분할 수 있는 유일한 값이다.

<br>

* ### ROWID는 "SELECT ROWID, EMPNO FROM EMP"와 같은 SELECT문으로 확인할 수 있다.

<br>

* ### ROWID는 데이터가 어떤 데이터 파일, 어떤 블록에 저장되어 있는지 알 수 있다.

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/864ad558-24f3-4355-9e91-a62f2a5a7733/image.png)