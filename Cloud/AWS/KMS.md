# **KMS**

<br>

### **`KMS(Key Management Service)`** 란 데이터를 암호화할 때 사용하는 **키(Encryption Key)를 쉽게 생성하고, 관리할 수 있게 해주는 서비스**이다.

<br>
<br>

---

<br>

## **KMS의 3가지 방식**

<br>

+ ### **AWS Managed Key**

    AWS 서비스들이 KMS를 통해 Key를 서비스 받는 것으로, **내부적으로 자동으로 일어나며 사용자가 직접적으로 제어가 불가능**하다.

+ ### **Customer Managed Key**

    **사용자가 직접 Key를 생성하고, 관리하는 것**으로 IAM을 통해 권한을 부여 받아 제어가 가능하다.

<br>

+ ### **Custom Key Stores**

   AWS에서 제공하는 또 다른 key 관리형 서비스인 CloudHSM을 활용해 KMS가 아닌 CloudHSM에 Key를 저장하여 사용하는 방식으로, `CloudHSM` 클러스터가 생성되어 있어야 사용 가능하다.



<br><br>

---

<br>

## **CMK(Customer Master Key)**

**'데이터를 암호화하는데 사용하는 데이터 키'** 의 **생성에 관여하는 키**이다.

<br>

AWS 서비스가 암호화를 시작할 때 CMK 생성을 요청한 후에 데이터 암호화를 시작한다. 즉, `CMK`를 생성한 후에 데이터 키를 생성하고, 데이터 암호화를 시작한다. 위에서 말한 3가지 유형은 **CMK를 누가 관리하냐**에 따라 달라진다.


<br><br>

---

<br>

## **KMS의 암호화 방식**
