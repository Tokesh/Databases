import random
with open("product_id.txt", "w")as external_file:
    for i in range(150):
        k = [random.choice('ZXCVBNMASDFGHJKLQWERTYUIOP1234567890') for _ in range(10)]
        res = ""
        for j in k:
            res += j
        print(res, file=external_file)

