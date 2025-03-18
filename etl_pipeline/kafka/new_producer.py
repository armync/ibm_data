from kafka import KafkaProducer
import json
producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'))
transid = 102
while True:
    user_input = input('Add a new transaction? (n stops): ')
    if user_input.lower() == 'n':
        print("Stopping...")
        break
    else:
        atm_choice = input('Which ATM? 1 or 2?')
        if (atm_choice == '1' or atm_choice == '2'):
            producer.send("bankbranch", {"atmid":int(atm_choice), "transid":transid})
            producer.flush()
            transid = transid + 1
        else:
            print('Invalid ATM number')
            continue

producer.close()
