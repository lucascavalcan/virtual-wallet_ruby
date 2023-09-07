# Virtual Wallet Manager

This is a simple Ruby on Rails application for managing users and their virtual wallets. Each user has one virtual wallet, which can have multiple entries for credits and debits. This application also provides API endpoints to interact with the virtual wallets.

## Project Description

The main features of this Virtual Wallet Manager application include:

* Listing users
* Adding a new user
* Editing an existing user
* Showing user details, including their virtual wallet's current balance
* Crediting or debiting money to/from a user's virtual wallet
* Listing virtual wallet entries ordered by date and time

Additionally, there are three API endpoints available:

1. Credit or debit money to the user's virtual wallet.
2. Retrieve an user's virtual wallet's current balance.
3. Retrieve an user's virtual wallet entries within a specified time period.

## Requirements

To run this application, you need the following:

* Ruby 2.4 or greater
* Rails 5.2 or greater
* A relational database (e.g., PostgreSQL, MySQL, or SQLite)
* Unix-compatible environment (Linux or macOS)

## Getting Started

Follow these steps to get the application up and running on your local machine:

1. Clone this repository:
    ```bash
    git clone https://github.com/yourusername/virtual_wallet_manager.git
    cd virtual_wallet_manager
2. Install the required gems:
    ```bash
    bundle install
3. Set up the database and run migrations:
    ```bash
    rails db:create
    rails db:migrate
4. Start the Rails server:
    ```bash
    rails server

Now, you should have the application running locally.

## Usage
Access the application in your web browser at http://localhost:3000. You can use the web interface to manage users and their virtual wallets.

## API Endpoints
This application provides the following API endpoints:

### 1. Credit or Debit Money
* Route: POST /api/v1/wallets/deposit_withdraw
* Description: Credit or debit money to the user's virtual wallet.
* Parameters:

    * 'user_id' (integer, required): User's ID.
    * 'amount' (float, obrigatório): Amount to be credited or debited.
    * 'operation' (string, obrigatório): Operation to be performed, which can be "deposit" or "withdraw."

### 2. Retrieve an user's virtual wallet current balance
* Route: GET /api/v1/wallets/balance
* Description: Retrieve the current balance of a user's virtual wallet.
* Parameters:

    * 'user_id' (integer, required): User's ID.

### 3. Retrieve an user's virtual wallet entries in a period of time
* Route: GET /api/v1/wallets/entries
* Description: Retrieve entries in a user's virtual wallet during a specified period of time.
* Parameters:

    * 'user_id' (integer, required): User's ID.
    * 'start_date' (date, required): Start date of the desired period.
    * 'end_date' (date, required): End date of the desired period.

## Testing
To run the tests for this application, you can use RSpec. Make sure you have RSpec installed:

    
    gem install rspec

Install the required gems:

    rspec

## License
This project is licensed under the MIT License. Feel free to use, modify, and distribute it as needed.