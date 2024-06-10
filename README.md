# Okto Wallet SDK Documentation

## Table of Contents

- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Usage](#usage)
  - [Initialization](#initialization)
  - [Authentication](#authentication)
    - [Authenticate with Google Sign-In](#authenticate-with-google-sign-in)
    - [Authenticate with User ID and JWT Token](#authenticate-with-user-id-and-jwt-token)
  - [Set Pin](#set-pin)
  - [Refresh Token](#refresh-token)
  - [User Details](#user-details)
  - [Wallet Management](#wallet-management)
    - [Create Wallet](#create-wallet)
    - [Get Wallets](#get-wallets)
  - [Supported Networks and Tokens](#supported-networks-and-tokens)
    - [Supported Networks](#supported-networks)
    - [Supported Tokens](#supported-tokens)
  - [User Portfolio](#user-portfolio)
    - [User Portfolio Activity](#user-portfolio-activity)
  - [Token Transfer](#token-transfer)
    - [Transfer Tokens](#transfer-tokens)
    - [Transfer NFT](#transfer-nft)
  - [Order Management](#order-management)
    - [Order History](#order-history)
    - [Order Details NFT](#order-details-nft)
  - [Raw Transactions](#raw-transactions)
    - [Execute Raw Transaction](#execute-raw-transaction)
    - [Raw Transaction Status](#raw-transaction-status)
  - [UI Components](#ui-components)
    - [Open Bottom Sheet](#open-bottom-sheet)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Welcome to the Okto Wallet SDK documentation. This SDK provides a comprehensive set of functionalities to integrate Okto Wallet services into your Flutter applications.

## Getting Started

Follow the steps below to set up and use the SDK in your Flutter project.

## Installation

Add the following dependency to your `pubspec.yaml` file:

## Usage

### Initialization

`final okto = Okto('your_client_api_key');`

### Authentication

- Authenticate with Google Sign-In
      Authenticate a new user using the ID token received from Google Sign-In.
      `final auth = await okto.authenticate(idToken: idToken);`

      after authenticating we have to call the set pin method.
      `final setPin = await okto.setPin(pin: '123453');`

       and that's it...

- Authenticate with User ID and JWT Token
     `await okto.authenticateWithUserId(userId: userId, jwtToken: jwtToken);`

## User Detials

- Get the user details
`final user =  await okto.userDetails();`

## Wallet Management

- Create a new wallet for the user:
    `final userWallet = await okto.createWallet();`

- Get the user wallets:
    `final userWallets = await okto.getWallets();`

## Supported Networks and Tokens

- Get Supported Networks
    `final supportedNetworks = await okto.supportedNetworks();`

    - Get Supported Tokens
    `final supportedTokens = await okto.supportedTokens();`
    You can provide optional parameters like page and size.

## User Portfolio

- Get the user portfolio
    `final userPortfolio = await okto.userPortfolio();`

- Get the user portfolio activity.
    `final userPortfolioActivity = await okto.getUserPortfolioActivity();`
    You can providen optional parameters like limit and offset.

## Token Transfer

- Transfer Tokens
    Transfer tokens from one wallet to another.

    ```
    final transferToken = await okto.transferToken(
    networkName: networkName,
    tokenAddress: tokenAddress,
    quantity: quantity,
    recipientAddress: recipientAddress,
    );

    ```

- Transfer NFT
    Transfer an NFT.
     ```
    final transferNft = await okto.transferNft(
    operationType: operationType,
    networkName: networkName,
    collectionAddress: collectionAddress,
    collectionName: collectionName,
    quantity: quantity,
    recipientAddress: recipientAddress,
    nftAddress: nftAddress,
    );
    ```

Network Names: "APTOS", "BASE", "POLYGON", "POLYGON_TESTNET_AMOY", "SOLANA", "SOLANA_DEVNET",

## Order Management

- Get order history:
    `final orderHistory = await okto.orderHistory()`
    You can provide optional parameters like:
        - Offset
        - limit
        - orderId
        - orderState

- Get order details for an NFT.
    `final orderDetailsNft = await okto.orderDetailsNft();`
        You can provide optional parameters like:
        - page
        - size
        - orderId
        - orderState

## Raw Transactions

- Execute Raw Transaction
    ```
    final rawTransaction =  await okto.rawTransactionExecute(
    networkName: networkName,
    fromAddress: fromAddress,
    toAddress: toAddress,
    data: data,
    value: value,
    );
    ```

Network Names: "APTOS", "BASE", "POLYGON", "POLYGON_TESTNET_AMOY", "SOLANA", "SOLANA_DEVNET",


- Raw Transaction Status:
    `final rawTransactionStatus = await okto.rawTransactionStatus(orderId: orderId);`

orderId that we get from the `rawTransaction` object.


## UI Components

- Open Bottom Sheet
    `await okto.openBottomSheet(context: context);`

    This opens up a okto widget inside a bottom sheet of your flutter app.

    You can customize all of these, according to your needs.
    ```
    textPrimaryColor: textPrimaryColor,
    textSecondaryColor: textSecondaryColor,
    textTertiaryColor: textTertiaryColor,
    accentColor: accentColor,
    accent2Color: accent2Color,
    strokBorderColor: strokBorderColor,
    strokDividerColor: strokDividerColor,
    surfaceColor: surfaceColor,
    backgroundColor: backgroundColor,
    ```