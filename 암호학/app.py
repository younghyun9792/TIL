# 암호학에서 쓰는 exploit 코드

from Crypto.Util.Padding import pad, unpad
from Crypto.Util.number import getPrime
from Crypto.Cipher import AES
import hashlib
import random

class Person(object):
    def __init__(self, p):
        self.p = p
        self.g = 2
        self.x = random.randint(2, self.p - 1)
    
    def calc_key(self):
        self.k = pow(self.g, self.x, self.p)
        return self.k

    def set_shared_key(self, k):
        self.sk = pow(k, self.x, self.p)
        aes_key = hashlib.md5(str(self.sk).encode()).digest()
        print(aes_key)
        self.cipher = AES.new(aes_key, AES.MODE_ECB)

    def encrypt(self, pt):
        return self.cipher.encrypt(pad(pt, 16)).hex()

    def decrypt(self, ct):
        return unpad(self.cipher.decrypt(bytes.fromhex(ct)), 16)

alice_f='e48e9174a9103e249f4bb809e13d58d49283e2438954799030be4854328adacbeb310c79bce3e91719f218158359af0d'
bob_f='2a69648d494907e551b69b74676f2e528644a526e5f7bc8b6300f1bd8ad5f091a9e40939960ea5bd0ad2ceff23a14f96'

prime = getPrime(1024)

Alice = Person(prime)
Bob = Person(prime)

alice_k = 1
bob_k = 1

Bob.set_shared_key(alice_k)
Alice.set_shared_key(bob_k)

print("They are sharing the part of flag")
print(Alice.decrypt(alice_f))
print(Bob.decrypt(bob_f))