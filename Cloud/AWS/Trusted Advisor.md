# **Trusted Advisor**

<br>

### `Trusted Advisor`는 모든 AWS 리전의 리소스를 검사하고 점검 결과 요약을 제공한다.

<br>

### 점검 내용에는 AWS를 효율적으로 사용하고 있는지, 비용을 아낄 수 있는지, 보안 설정은 잘 되어 있는지 등이 있다.

<br><br>

---

<br>

## 점검 분야

<br>

+ ### 비용 최적화(Cost Optimization)

+ ### 성능(Performance)

+ ### 보안(Security)

+ ### 내결한도(Fault Tolerance)

+ ### 서비스한도(Service Limits)

<br>

> ### 항목 당 3가지로 결과가 출력된다.  
> + ### 빨간색 : 조치 필요
> + ### 노란색 : 조사 필요
> + ### 초록색 : 문제 없음


<br><br>

---

<br>

### 또한, [CloudWatch](./CloudWatch.md)나 `EventBridge`등과 연동하여 `Trusted Advisor`의 주기적 검사 시기에 대한 변경을 감지할 수 있다.

<br>

### 그리고, `Trusted Advisor`는 `business Support`레벨 이상의 계정에만 모든 항목을 무료로 체크해준다.