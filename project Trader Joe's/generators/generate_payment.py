import random
import datetime



with open("payment.txt", "w")as external_file:
    for i in range(50):
        z = random.randint(5,150)
        t = z * 1.05
        typez = random.randint(0,1)
        lz = ""
        if(typez == 0): lz = "cash"
        else: lz = "card"
        print(f"insert into payment(summ, total_price, payment_type) values(%s,%s, '%s');" % (z,t,lz), file = external_file) 