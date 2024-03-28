import connector_dynamo
import connector_oracle

# Establish connection to Oracle database
conn = connector_oracle.connOracle()

# Establish connection to DynamoDB table
#table = connector_dynamo.connDynamo()

# Read data from DynamoDB table
#data1 = connector_dynamo.read_item_table(table, "PM_Review_M")
#data2 = connector_dynamo.read_item_table(table, "PM_Review_Json_M")


# Check if the Oracle connection is established
if conn:
    for index, d in enumerate(data1):
        timeID = d["Date"]
        customerID = int(d["customerID"])
        score = float(d["score"])
        query = "INSERT INTO DW04_FT_RATING(timeID, customerID, score) VALUES (TO_DATE(:1, 'YYYY-MM-DD'), :2, :3)"
        data_Oracle = (timeID, customerID, score)
        connector_oracle.insert_data(conn, query, data_Oracle)
"""
    for index,d in  enumerate(data2):
        timeID = d["Date"]
        customerID = int(d["customerID"])
        score = d["feedback"]['score']
        query = "INSERT INTO DW04_FT_RATING(timeID, customerID, score) VALUES (TO_DATE(:1, 'YYYY-MM-DD'), :2, :3)"
        data_Oracle = (timeID, customerID, score)
        connector_oracle.insert_data(conn, query, data_Oracle)
"""     
