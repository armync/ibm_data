# !pip install pandas

import pandas
import sqlite3

con = sqlite3.connect('FinalDB.db')

%load_ext sql

df = pandas.read_csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DB0201EN-SkillsNetwork/labs/FinalModule_Coursera_V5/data/ChicagoCensusData.csv?utm_medium=Exinfluencer&utm_source=Exinfluencer&utm_content=000026UJ&utm_term=10006555&utm_id=NA-SkillsNetwork-Channel-SkillsNetworkCoursesIBMDeveloperSkillsNetworkDB0201ENSkillsNetwork20127838-2021-01-01')
df2 = pandas.read_csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DB0201EN-SkillsNetwork/labs/FinalModule_Coursera_V5/data/ChicagoPublicSchools.csv?utm_medium=Exinfluencer&utm_source=Exinfluencer&utm_content=000026UJ&utm_term=10006555&utm_id=NA-SkillsNetwork-Channel-SkillsNetworkCoursesIBMDeveloperSkillsNetworkDB0201ENSkillsNetwork20127838-2021-01-01')
df3 = pandas.read_csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DB0201EN-SkillsNetwork/labs/FinalModule_Coursera_V5/data/ChicagoCrimeData.csv?utm_medium=Exinfluencer&utm_source=Exinfluencer&utm_content=000026UJ&utm_term=10006555&utm_id=NA-SkillsNetwork-Channel-SkillsNetworkCoursesIBMDeveloperSkillsNetworkDB0201ENSkillsNetwork20127838-2021-01-01')

df.to_sql('Chicago_Census_Data',con,if_exists='replace',index=False)
df2.to_sql('Chicago_Public_Schools',con,if_exists='replace',index=False)
df3.to_sql('Chicago_Crime_Data',con,if_exists='replace',index=False)

%sql sqlite:///FinalDB.db

%sql SELECT COUNT(*) FROM Chicago_Crime_Data

%sql SELECT COMMUNITY_AREA_NUMBER, COMMUNITY_AREA_NAME, PER_CAPITA_INCOME \
    FROM Chicago_Census_Data \
    where PER_CAPITA_INCOME < 11000

#%sql SELECT CASE_NUMBER FROM Chicago_Crime_Data WHERE primary_type = 'OFFENSE INVOLVING CHILDREN'

%sql SELECT * FROM Chicago_Crime_Data WHERE description LIKE "%MINOR%"

%sql SELECT * FROM Chicago_Crime_Data WHERE description LIKE "%MINOR%"

%sql SELECT * FROM Chicago_Crime_Data WHERE PRIMARY_TYPE = "KIDNAPPING" AND DESCRIPTION LIKE '%CHILD%'

%sql SELECT DISTINCT(PRIMARY_TYPE) FROM Chicago_Crime_Data WHERE LOCATION_DESCRIPTION LIKE '%SCHOOL%'

%sql SELECT [Elementary, Middle, or High School] AS 'School_Type', AVG(Safety_Score) AS 'AVG_Safety_Score' \
FROM Chicago_Public_Schools \
GROUP BY [Elementary, Middle, or High School]

%sql SELECT COMMUNITY_AREA_NAME, COMMUNITY_AREA_NUMBER, PERCENT_HOUSEHOLDS_BELOW_POVERTY \
FROM Chicago_Census_Data \
ORDER BY PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC \
LIMIT 5

%sql SELECT COMMUNITY_AREA_NUMBER \
    FROM Chicago_Crime_Data \
    WHERE COMMUNITY_AREA_NUMBER IS NOT NULL \
    GROUP BY COMMUNITY_AREA_NUMBER \
    ORDER BY COUNT(*) DESC

%sql SELECT COMMUNITY_AREA_NAME \
FROM Chicago_Census_Data \
WHERE HARDSHIP_INDEX = (SELECT MAX(HARDSHIP_INDEX) FROM Chicago_Census_Data)

%sql SELECT COMMUNITY_AREA_NAME \
    FROM Chicago_Census_Data\
    WHERE COMMUNITY_AREA_NUMBER = (SELECT COMMUNITY_AREA_NUMBER \
                                    FROM Chicago_Crime_Data \
                                    WHERE COMMUNITY_AREA_NUMBER IS NOT NULL \
                                    GROUP BY COMMUNITY_AREA_NUMBER \
                                    ORDER BY COUNT(*) DESC \
                                    LIMIT 1)

