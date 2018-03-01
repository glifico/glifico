from hashlib import sha256

user=str(input('insert user: '))
password=str(input('insert pwd: '))
password=user+'startup'+password

print sha256(password).hexdigest()
