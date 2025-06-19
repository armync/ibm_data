from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago
from datetime import timedelta, datetime

default_args = {
    'owner': 'User',
    'start_date': days_ago(1),
    'email': ['me@mail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'process_web_log',
    default_args=default_args,
    description='Apache Airflow Capstone',
    schedule_interval='@daily',
)

extract_data = BashOperator(
    task_id='extract_data',
    bash_command="awk '{print $1}' extracted_data.txt",
    dag=dag,
)

transform_data = BashOperator(
    task_id='transform_data',
    bash_command="grep -v '^198\\.46\\.149\\.143$' extracted_data.txt > transformed_data.txt",
    dag=dag,
)

load_data = BashOperator(
    task_id='load_data',
    bash_command="tar -cvf weblog.tar transformed_data.txt",
    dag=dag,
)

extract_data >> transform_data >> load_data