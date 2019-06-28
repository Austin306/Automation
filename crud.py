import pymysql

def fetch_values():
        f='/tmp/terraform.tfstate'
        with open(f, 'r') as file:
                d=json.loads(file.read())
        url=d["modules"]["outputs"]["fetch the endpoint url displayed in the json"] 
        name=d["modules"]["outputs"]["fetch the username displayed in the json"]
        password=d["modules"]["outputs"]["fetch the password displayed in the json"]
        return url,name,password 


def connection():
    url , name , password = fetch_values()
    try:
        conn = pymysql.connect(host=url,user=name,passwd=password,port=3306)
        print("connected.")
        return conn
    except Exception as e:
        print(e)
def main():
# prepare a cursor object using cursor() method
    db = connection()
    cursor = db.cursor()
    cursor.execute("DROP TABLE IF EXISTS EMPLOYEE")
    # Create table as per requirement
    sql = """CREATE TABLE EMPLOYEE (
    FIRST_NAME  CHAR(20) NOT NULL,
    LAST_NAME  CHAR(20),
    AGE INT,  
    SEX CHAR(1),
    INCOME FLOAT )"""

    cursor.execute(sql)
    print("created table")
    cursor.execute("INSERT INTO EMPLOYEE(FIRST_NAME, LAST_NAME, AGE, SEX, INCOME) VALUES ('Austin', 'Dsouza', 40, 'M', 2800)")
    cursor.execute("INSERT INTO EMPLOYEE(FIRST_NAME, LAST_NAME, AGE, SEX, INCOME) VALUES ('Akash', 'Mohan', 50, 'M', 2090)")
    cursor.execute("INSERT INTO EMPLOYEE(FIRST_NAME, LAST_NAME, AGE, SEX, INCOME) VALUES ('Mac', 'Apple', 20, 'M', 2000)")



    cursor.execute("Select * from  EMPLOYEE")
    results = cursor.fetchall()
    print(results)

    #delete

    cursor.execute("DELETE FROM EMPLOYEE WHERE AGE < 25 ")

    #update

    cursor.execute("UPDATE EMPLOYEE SET AGE = AGE + 1 WHERE SEX = 'M'")

    print(cursor.execute("Select * from EMPLOYEE"))
    results = cursor.fetchall()
    print(results)

    #select to see the update

    cursor.execute("Select * from  EMPLOYEE")


    db.commit()
    # disconnect from server
    db.close()
if __name__ == '__main__':
    main()
