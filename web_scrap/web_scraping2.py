import requests
import sqlite3
import pandas as pd
from bs4 import BeautifulSoup

# Rotten Tomatoes Top 100 URL (archived)
url = 'https://web.archive.org/web/20230902185655/https://en.everybodywiki.com/100_Most_Highly-Ranked_Films'
db_name = 'Movies.db'
table_name = 'Top_100'
csv_path = '/home/project/top_100_films.csv'

df = pd.DataFrame(columns=["Film", "Year", "Rotten Tomatoes' Top 100"])
count = 0

# Fetch and parse the webpage
html_page = requests.get(url).text
data = BeautifulSoup(html_page, 'html.parser')

tables = data.find_all('tbody')
rows = tables[0].find_all('tr')

for row in rows:
    if count < 100:
        col = row.find_all('td')
        if len(col) != 0:
            year = int(col[2].contents[0])
            if year >= 2000:
                data_dict = {
                    "Film": col[1].contents[0],
                    "Year": year,
                    "Rotten Tomatoes' Top 100": "Yes"
                }
                df1 = pd.DataFrame(data_dict, index=[0])
                df = pd.concat([df, df1], ignore_index=True)
                count += 1
    else:
        break

print(df)

# Save to CSV
df.to_csv(csv_path, index=False)

# Save to SQLite database
conn = sqlite3.connect(db_name)
df.to_sql(table_name, conn, if_exists='replace', index=False)
conn.close()