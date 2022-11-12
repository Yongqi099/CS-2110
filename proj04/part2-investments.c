#include "part2-investments.h"

/*
* Name: Yongqi Ma
* Collaborators:
* Please list anyone you collaborated with on this file here.
*/

struct account myAccount;

int getStockValue(struct stockProperties stock) {
    return stock.numShare * stock.price;
}

/** openAccount
*
* Opens a new account in the system.
*
* Initialize the global account struct with the name and balance passed in.
* You will not be able to assign strings directly, see the PDF for more details.
*
* @param "name" the name string to copy into the global account struct.
* @param "balance" the balance to set in the global account struct.
* @return SUCCESS on success, ERROR on failure
*         Failure occurs if ANY of the following are true:
*         (1) The length of `name`, excluding NULL terminator, is too short (< 3 characters).
*         (2) The length of `name`, excluding NULL terminator, is too long (> 15 characters).
*         (3) `balance` is negative.
*/
int openAccount(char* name, float balance) {

    int length = strlen(name);
    if (balance < 0 || length < 3 || length > 15) {
        return ERROR;
    }

    int len = 0;
    for(char *p = name; *p; p++) {
        myAccount.accountName[len++] = *p;
    }
    myAccount.totalBalance = balance;
    return SUCCESS;
}

/** closeAccount
*
* Closes the account in the system.
*
* Set the account name to "".
* Set the total balance to 0.
* Set the total number of stocks bought to 0.
*
*/
void closeAccount(void) {
    myAccount.accountName[0] = '\0';
    myAccount.totalBalance = 0;
    myAccount.totalStocksBought = 0;
}

/** createAcro
*
* Create an acronym (stock ticker) for a given stock.
*
* An acronym can be generated from a stock name by using the following formula:
* First letter + first vowel + last character.
*
* You may assume the name passed in contains a vowel.
* Stock names may be uppercase, lowercase, or any mix of the two.
*
* @param "name" The name of the stock to create an acronym from. Do not change this string.
* @param "acro" The string to write the outputted acronym to.
* @return SUCCESS on success, ERROR on failure
*         Failure occurs if ANY of the following are true:
*         (1) `name` is NULL.
*         (2) The length of `name`, excluding NULL terminator, is too short (< 3 characters).
*         (3) The length of `name`, excluding NULL terminator, is too long (> 15 characters).
*/
int createAcro(char* name, char* acro) {
    int length = strlen(name);

    if (name[0] == '\0' || length < 3 || length > 15) {
        return ERROR;
    }

    int vowelIndex = 0;
    char vowels[] = "aeiou";
    for (int i = 0; i < length; ++i) {
        // set name[i] to lowercase
        char curChar = name[i];
        curChar = curChar > 64 && curChar < 91 ? curChar | 0x60 : curChar;

        // check if name[i] is a vowel
        for (char *j = vowels; *j; j++) {

            if (curChar == *j) {
                vowelIndex = i;
                goto Create;
            }
        }
    }

    Create:
    acro[0] = name[0];
    acro[1] = name[vowelIndex];
    acro[2] = name[length-1];
    return SUCCESS;
}

/** buyStock
*
* Buy shares of a stock in the system.
*
* On success, you should subtract the cost of the stock from the account's balance.
* You should also update the number of shares owned in the stock array.
*
* @param "stock" the stock you want to buy.
* @param "shareCount" the number of shares to buy.
* @return SUCCESS on success, ERROR on failure
*         Failure occurs if ANY of the following are true:
*         (1) You cannot afford to make the purchase requested.
*         (2) Buying the stock would make you exceed the maximum number of stocks.
*/
int buyStock(struct stockInfo stock, int shareCount) {
    float total_cost = stock.price * shareCount;

    // check failure conditions
    if (myAccount.totalBalance < total_cost || MAX_NUM_STOCKS <= myAccount.totalStocksBought) {
        return ERROR;
    }

    int purchase = 1;
    // if buying stock in portfolio
    for (int i = 0; i < myAccount.totalStocksBought; i++) {
        if (strcmp(stock.name, myAccount.stocksArr[i].name) == 0) {
            purchase = 0;
            myAccount.totalBalance -= total_cost;
            myAccount.stocksArr[i].numShare += shareCount;
        }
    }
    // if purchasing new stock
    if (purchase) {
        struct stockProperties newStock;
        strcpy(newStock.name, stock.name);
        createAcro(stock.name, newStock.acronym);
        newStock.price = stock.price;
        newStock.numShare = shareCount;
        newStock.sector = stock.sector;
        myAccount.stocksArr[myAccount.totalStocksBought] = newStock;

        myAccount.totalBalance -= total_cost;
        myAccount.totalStocksBought++;
    }
    return SUCCESS;
}

/** sellStock
*
* Sell shares of a stock in the system.
*
* On success, you should add the cost of the shares sold to your account's balance.
* You should also update the number of shares owned in the stock array.
*
* @param "stock" the stock you want to sell.
* @param "shareCount" the number of shares to sell.
* @return SUCCESS on success, ERROR on failure
*         Failure occurs if ANY of the following are true:
*         (1) The specified stock does not exist in the account's stock array.
*         (2) You do not have enough of the specified stock to sell.
*/
int sellStock(struct stockInfo stock, int shareCount) {
    int error = 1;

    for (int i = 0; i < myAccount.totalStocksBought; i++) {
        if (strcmp(stock.name, myAccount.stocksArr[i].name) == 0 && shareCount <= myAccount.stocksArr[i].numShare) {
            error = 0;
            myAccount.totalBalance += shareCount * stock.price;
            myAccount.stocksArr[i].numShare -= shareCount;
            if (myAccount.stocksArr[i].numShare == 0) {
                for (int j = i + 1; j < myAccount.totalStocksBought; j++) {
                    myAccount.stocksArr[j-1] = myAccount.stocksArr[j];
                }
                myAccount.totalStocksBought--;
            }
        }
    }
    if (error) {
        return ERROR;
    }
    return SUCCESS;
}

/** sortStockInvest
*
* Sort the account's stock array by the stock's total value.
* The array should be sorted in increasing order.
* In other words, the stock with the lowest total value should be first in the sorted array.
*
* Note that each stock's total value is calculated by multiplying its price by its share count.
*
* It does not matter what sorting algorithm you use, but it should be a stable sort.
* In other words, you should maintain the original order for two stocks with the same total value.
*/
void sortStockInvest(void) {
    int n = myAccount.totalStocksBought;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (getStockValue(myAccount.stocksArr[j]) > getStockValue(myAccount.stocksArr[j + 1])) {
                struct stockProperties tmp = myAccount.stocksArr[j];
                myAccount.stocksArr[j] = myAccount.stocksArr[j + 1];
                myAccount.stocksArr[j + 1] = tmp;
            }
        }
    }
}

/** sortStockSector
*
* Sort the account's stock array by the stock sector.
*
* The array should be sorted in the order [CRYPTO, ENERGY, TECHNOLOGY].
* In other words, CRYPTO stocks should be first in the array; TECHNOLOGY stocks should be last.
*
* It does not matter what sorting algorithm you use, but it should be a stable sort.
* In other words, you should maintain the original order for two stocks with the same sector.
*/
void sortStockSector(void) {
    int n = myAccount.totalStocksBought;
    for (int i = 0; i < n; i++) {
        // bubble cryptos to the bottom
        for (int j = n - i - 1; j > 0; j--) {
            if (myAccount.stocksArr[j].sector == 0 && myAccount.stocksArr[j - 1].sector != 0) {
                struct stockProperties tmp = myAccount.stocksArr[j];
                myAccount.stocksArr[j] = myAccount.stocksArr[j - 1];
                myAccount.stocksArr[j - 1] = tmp;
            }
        }
        // bubble tech to the top
        for (int j = 0; j < n - i - 1; j++) {
            if (myAccount.stocksArr[j].sector == 2 && myAccount.stocksArr[j + 1].sector != 2) {
                struct stockProperties tmp = myAccount.stocksArr[j];
                myAccount.stocksArr[j] = myAccount.stocksArr[j + 1];
                myAccount.stocksArr[j + 1] = tmp;
            }
        }
    }
}

/** totalInvestment
*
* Calculate the total value of the account.
*
* The total value of the account is the sum of the total value of each stock.
* The total value of each stock is its price multiplied by its share count.
*
* If there are no stocks in the account, the total value is 0.
*
* @return the total value of the account.
*/
float totalInvestment(void) {
    float total = 0;
    for (int i = 0; i < myAccount.totalStocksBought; i++) {
        total += getStockValue(myAccount.stocksArr[i]);
    }
    return total;
}

/** sectorInvestment
*
* Calculate the total value of a stock sector in the account.
*
* The total value of a sector in the account is the sum of the total value of each stock belonging to that sector.
* The total value of each stock is its price multiplied by its share count.
*
* If there are no stocks of that sector type in the account, the value of the sector is 0.
*
* @return the total value of the sector.
*/
float sectorInvestment(enum sectorType sector) {
    float total = 0;
    for (int i = 0; i < myAccount.totalStocksBought; i++) {
        if (myAccount.stocksArr[i].sector == sector) {
            total += getStockValue(myAccount.stocksArr[i]);
        }
    }
    return total;
}