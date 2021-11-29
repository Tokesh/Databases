import random
import datetime



zxc=[]
zxc.append(26)
with open("order.txt", "w")as external_file:
    for i in range(50):
        z = random.randint(1,102)
        l = random.randint(0,1)
        res = 'null'
        if(l == 1): res = str(random.randint(1,20))
        pay = random.randint(51,100)
        while(pay in zxc): pay=random.randint(1,50)
        zxc.append(pay)
        store = random.randint(1,25)
        date=datetime.date(random.randint(2010,2021), random.randint(1,12),random.randint(1,28))
        cash_air = 'null'
        if(res == 'null'): cash_air = str(random.randint(1,10))
        
        print(f"insert into orders(client_id, delivery_number_id, payment_id, store_id, date_time, cash_air) values(%s, %s, %s, %s, '%s', %s);" % (z, res, pay, store, date, cash_air), file = external_file)
        