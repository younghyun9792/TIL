# 암호학에서 쓰는 exploit 코드

from Crypto.Util.Padding import pad, unpad
from Crypto.Cipher import AES
import hashlib
import random
alice=0xe48e9174a9103e249f4bb809e13d58d49283e2438954799030be4854328adacbeb310c79bce3e91719f218158359af0d
bob=0x2a69648d494907e551b69b74676f2e528644a526e5f7bc8b6300f1bd8ad5f091a9e40939960ea5bd0ad2ceff23a14f96

print(unpad(bytes.fromhex(alice)), 16)
print(unpad(bytes.fromhex(bob)), 16)