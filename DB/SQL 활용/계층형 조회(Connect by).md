# **계층형 조회(Connect by)**

<br>

* ### 계층형 조회는 Oracle DB에서 지원하는 것으로 계층형으로 데이터를 조회할 수 있다.

<br>

* ### 예를 들어 부장에서 차장, 차장에서 과장, 과장에서 대리, 대리에서 사원 순으로 트리 형태의 구조를 위에서 아래로 탐색하면서 조회하는 것이다.

<br>

* ### Connect by는 트리 형태의 구조로 질의를 수행하는 것으로 START WITH 구는 시작 조건을 의미하고 CONNECT BY PRIOR은 조인 조건이다. Root 노드로부터 하위 노드의 질의를 실행한다.

<br>

* ### 계층형 조회에서 최대 계층의 수를 구하기 위한 문제. MAX(LEVEL)을 사용하여 최대 계층 수를 구한다. 즉, 계층형 구조에서 마지막 Leaf Node의 계층 값을 구한다.

<br>

```sql
SELECT MAX(LEVEL)
FROM Limbest.EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;
```

<br>

* ### 위의 예에서 MAX(LEVEL)이 4이면, 트리의 최대 깊이가 4인 것이다.

<br>

```sql
SELECT LEVEL, EMPNO, MGR, ENAME
FROM Limbest.EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR:
```

<br>

* ### 위의 예에서 EMPNO과 MGR 컬럼 모두 사원번호가 입력되어 있는데, MGR은 관리자 사원번호를 가지고 있다. 즉, MGR 1000번은 1001과 1002의 사원을 관리한다.

<br>

* ### 계층형 조회 결과를 명확히 보기 위해서 LPAD 함수를 사용할 수 있다.

<br>

```sql
SELECT LEVEL, LPAD(' ', 4 * (LEVEL - 1) ) || EMPNO, MGR, CONNECT_BY_ISLEAF
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;
```

<br>

* ### 위의 예에선 4*(LEVEL-1)이 있는데 LEVEL 값은 Root면 1이 된다. 즉 Root 일 때는 0이 되는데 Root일 때는 LPAD(' ',0)이므로 아무 의미가 없다.

<br>

* ### 하지만, LEVEL 값이 2가 되면 4가 되므로, LPAD(' ',4)이므로 왼쪽에 공밴 4칸을 출력한다.

<br>

* ### 결과적으로 LPAD는 트리 형태로 보기 위해 사용한 것이다.

<br>

* ### CONNECT BY 키워드

<br>

![이미지](https://velog.velcdn.com/images/as979200/post/91fe4d26-ed02-4f64-b93c-5bc0ae12d4d8/image.png)