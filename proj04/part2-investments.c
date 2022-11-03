#include "part2-investments.h"

/*
 * Name: YOUR NAME HERE
 * Collaborators:
 * Please list anyone you collaborated with on this file here.
 */

struct account myAccount;

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
    UNUSED(name);
    UNUSED(balance);
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
    UNUSED(name);
    UNUSED(acro);
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
    UNUSED(stock);
    UNUSED(shareCount);
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
    UNUSED(stock);
    UNUSED(shareCount);
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
    return SUCCESS;
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
    UNUSED(sector);
    return SUCCESS;
}
