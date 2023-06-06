#include <iostream>
#include <iomanip>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

const int numberOfColumns = 5;

int main(void)
{
    //------------------------------------------------ Variable declaration -----------------------------------------------------//
    // Integers
    int lineWidth = 90;                                                     // Report page width
    int paddingWidth = 0;                                                   // Title padding
    int columnWidths[numberOfColumns] = { 12, 17, 17, 16, 9 };              // Column widths

    // Strings
    string sqlStatement = "";                                               // SQL statement for the queries
    string reportTitle = "";                                                // Report titles: 1 - Employees, 2 - Managers
    string userName = "dbs211_231naa06";                                    // dbs211 database username
    string password = "21357217";                                           // dbs211 database password
    string connectString = "myoracle12c.senecacollege.ca:1521/oracle12c";   // dbs211 database hostname

    // occi classes
    Environment* environment = nullptr;
    Connection* connection = nullptr;
    Statement* statement = nullptr;
    ResultSet* results = nullptr;
    //---------------------------------------------------------------------------------------------------------------------------//

    // Try-Catch block in case there is an exception throw during the connection
    try
    {
        // Instantiating (respectively): environment, connection, statement 
        environment = Environment::createEnvironment(Environment::DEFAULT);
        connection = environment->createConnection(userName, password, connectString);
        statement = connection->createStatement();

        //--------------------------------------------- Report 1 (Employee Report) ----------------------------------------------//
        // Set the SQL statement
        sqlStatement = "SELECT\
                            employees.employeeNumber,\
                            employees.firstName,\
                            employees.lastName,\
                            offices.phone,\
                            employees.extension\
                        FROM dbs211_employees employees\
                            JOIN dbs211_offices offices\
                                ON employees.officeCode = offices.officeCode\
                        WHERE offices.City = 'San Francisco'\
                        ORDER BY employees.employeeNumber";
        statement->setSQL(sqlStatement);

        // Store results
        results = statement->executeQuery();

        // Check if there was at least 1 result
        if (!results->next())
            std::cout << "No rows to display" << std::endl;
        else
        {
            // Table title
            reportTitle = "Report 1 (Employee Report)";
            paddingWidth = (lineWidth - reportTitle.length()) / 2;
            cout << setw(paddingWidth) << setfill('-') << right << " ";
            cout << reportTitle;
            cout << setw(paddingWidth) << setfill('-') << left << " " << endl;
            cout << setfill(' ');

            // Table header
            cout << "Employee ID   First Name         Last Name          Phone             Extension" << endl;
            cout << "------------  -----------------  -----------------  ----------------  ---------" << endl;
            do
            {
                // Table rows according the table header
                cout << setw(columnWidths[0]) << results->getInt(1) << "  ";
                cout << setw(columnWidths[1]) << results->getString(2) << "  ";
                cout << setw(columnWidths[2]) << results->getString(3) << "  ";
                cout << setw(columnWidths[3]) << results->getString(4) << "  ";
                cout << setw(columnWidths[4]) << results->getString(5) << "  " << endl;
            } while (results->next());
        }
        cout << endl;
        //-----------------------------------------------------------------------------------------------------------------------//


        //---------------------------------------------- Report 2 (Manager Report) ----------------------------------------------//
        // Set the SQL statement
        sqlStatement = "SELECT DISTINCT\
                            managers.employeeNumber,\
                            managers.firstName,\
                            managers.lastName,\
                            offices.phone,\
                            managers.extension\
                        FROM dbs211_employees managers\
                            JOIN dbs211_offices offices\
                                ON managers.officeCode = offices.officeCode\
                            JOIN dbs211_employees employees\
                                ON employees.reportsTo = managers.employeeNumber\
                        ORDER BY managers.employeeNumber";
        statement->setSQL(sqlStatement);

        // Store results
        results = statement->executeQuery();

        // Check if there was at least 1 result
        if (!results->next())
            std::cout << "No rows to display" << std::endl;
        else
        {
            // Table title
            reportTitle = "Report 2 (Manager Report)";
            paddingWidth = (lineWidth - reportTitle.length()) / 2;
            cout << setw(paddingWidth) << setfill('-') << right << " ";
            cout << reportTitle;
            cout << setw(paddingWidth) << setfill('-') << left << " " << endl;
            cout << setfill(' ');

            // Table header
            cout << "Employee ID   First Name         Last Name          Phone             Extension" << endl;
            cout << "------------  -----------------  -----------------  ----------------  ---------" << endl;
            do
            {
                // Table rows according the table header
                cout << setw(columnWidths[0]) << results->getInt(1) << "  ";
                cout << setw(columnWidths[1]) << results->getString(2) << "  ";
                cout << setw(columnWidths[2]) << results->getString(3) << "  ";
                cout << setw(columnWidths[3]) << results->getString(4) << "  ";
                cout << setw(columnWidths[4]) << results->getString(5) << "  " << endl;
            } while (results->next());
        }
        //-----------------------------------------------------------------------------------------------------------------------//

        // Terminating (respectively): statement, connection, and environment
        connection->terminateStatement(statement);
        environment->terminateConnection(connection);
        Environment::terminateEnvironment(environment);
    }
    catch(SQLException& sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }

    return 0;
}