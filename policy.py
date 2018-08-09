import base64
import json
import time
import hmac
import hashlib

handle = ''
expiry = str(int(time.time() + 60*60))
json_policy = '{"handle":"%s","expiry":%s}'% (handle, expiry)
policy = base64.urlsafe_b64encode(json_policy)
print policy

secret = 'MYGBA2RMQNAGRPZSQIUCB2QMKY'
print hmac.new(secret, policy, hashlib.sha256).hexdigest()
