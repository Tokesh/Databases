import names
import datetime
import random
import radar
#f = open("demofile.txt", "r")

def random_phone_num_generator():
    first = str(random.randint(100, 999))
    second = str(random.randint(1, 888)).zfill(3)
    last = (str(random.randint(1, 9998)).zfill(4))
    while last in ['1111', '2222', '3333', '4444', '5555', '6666', '7777', '8888']:
        last = (str(random.randint(1, 9998)).zfill(4))
    return '{}-{}-{}'.format(first, second, last)

with open("myfile.txt", "w")as external_file:
    for i in range(100):
        print("insert into clients(client_type, client_name, date_of_birth, gender, phone_number) values(",end='',file=external_file)

        rand_type = random.randint(0,1)
        if(rand_type ==0): print("'", "web","',", end='', sep='',file=external_file)
        else: print("'","loyalty","',", end='', sep='',file=external_file)

        rand_name = names.get_last_name()
        print("'",rand_name,"',", end='',sep='',file=external_file)

        date=datetime.date(random.randint(1950,2002), random.randint(1,12),random.randint(1,28))
        print("'",date,"',", end='', sep='',file=external_file)

        rand_type2 = random.randint(0,1)
        if(rand_type ==0): print("'","male","',", end='',sep='',file=external_file)
        else: print("'","female","',", end='',sep='',file=external_file)

        print("'",random_phone_num_generator(),"');", sep='',file=external_file)