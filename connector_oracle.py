import oracledb
import os

# Set your Oracle connection credentials
username = "AdvDBS04"
password = "CSKMITL_MAS"
dsn = "161.246.35.106:1521/orcldb" 

def connOracle():
    try:
        # Establish a connection to the Oracle database
        connection = oracledb.connect(user=username, password=password, dsn=dsn)

        # Check if the connection is successful
        if connection:
            print("Connection established successfully!")

        return connection

    except oracledb.DatabaseError as e:
        print("Error occurred:", e)
        return None

def execute_query(connection, query):
    try:
        cursor = connection.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        cursor.close()
        return rows
    except oracledb.DatabaseError as e:
        print("Error occurred while executing query:", e)
        return None

def insert_data(connection, query, data):
    try:
        cursor = connection.cursor()

        cursor.execute(query, data)
        connection.commit()
        cursor.close()
        print("Data inserted successfully!")
    except oracledb.DatabaseError as e:
        print("Error occurred while inserting data:", e)

def update_data(connection, update_query):
    try:
        cursor = connection.cursor()
        cursor.execute(update_query)
        connection.commit()
        cursor.close()
        print("Data updated successfully!")
    except oracledb.DatabaseError as e:
        print("Error occurred while updating data:", e)

def delete_data(connection, delete_query):
    try:
        cursor = connection.cursor()
        cursor.execute(delete_query)
        connection.commit()
        cursor.close()
        print("Data deleted successfully!")
    except oracledb.DatabaseError as e:
        print("Error occurred while deleting data:", e)

connOracle()