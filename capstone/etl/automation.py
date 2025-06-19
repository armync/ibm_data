# Import libraries required for connecting to mysql
import mysql.connector
# Import libraries required for connecting to DB2 or PostgreSql
import psycopg2
from datetime import datetime

# Connect to MySQL
mysql_conn = mysql.connector.connect(user='root',password='nHRk1TDOOqfL3F9DGpJEsvTH',host='172.21.179.119',database='sales')
mysql_cursor = mysql_conn.cursor()

# Connect to DB2 or PostgreSql
dsn_hostname = '172.21.122.16'
dsn_user = 'postgres'
dsn_pwd = 'EMkwoThOLe8r5wTPHdGCglWl'
dsn_port = '5432'
dsn_database = 'postgres'
pg_conn = psycopg2.connect(
    database=dsn_database,
    user =dsn_user,
    password=dsn_pwd,
    host=dsn_hostname,
    port=dsn_port
)
pg_cursor = pg_conn.cursor()

# Find out the last rowid from DB2 data warehouse or PostgreSql data warehouse
def get_last_rowid():
    pg_cursor.execute("SELECT MAX(rowid) FROM sales_data;")
    result = pg_cursor.fetchone()
    return result[0] if result and result[0] else 0

last_row_id = get_last_rowid()
print("Last row id on production datawarehouse = ", last_row_id)

# List out all records in MySQL database with rowid greater than the one on the Data warehouse
def get_latest_records(rowid):
    mysql_cursor.execute("SELECT rowid, product_id, customer_id, quantity FROM sales_data WHERE rowid > %s", (rowid,))
    result = mysql_cursor.fetchall()
    return result

new_records = get_latest_records(last_row_id)
print("New rows on staging datawarehouse = ", len(new_records))

# Insert the additional records from MySQL into DB2 or PostgreSql data warehouse
def insert_records(records):
    insert_query = """
        INSERT INTO sales_data (rowid, product, category, quantity, price, timeestamp)
        VALUES(%s, %s, %s, %s, %s, %s)
    """

    for row in records:
        # MySQL: (rowid, product_id, customer_id, quantity)
        # PostgreSQL: (rowid, product, category, quantity, price, timestamp)
        
        mapped_row = (
            row[0],  # rowid -> rowid
            row[1],  # product_id -> product
            'Unknown',  # default category (since MySQL doesn't have this)
            row[3],  # quantity -> quantity
            0.00,  # default price (since MySQL doesn't have this)
            datetime.now()  # current timestamp
        )
        
        pg_cursor.execute(insert_query, mapped_row)
    
    # all at once (perf)
    pg_conn.commit()

insert_records(new_records)
print("New rows inserted into production datawarehouse = ", len(new_records))

# disconnect from mysql warehouse
mysql_cursor.close()
mysql_conn.close()

# disconnect from DB2 or PostgreSql data warehouse
pg_cursor.close()
pg_conn.close()

# End of program