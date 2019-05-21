# Ethereum-Election

This projects is about the digital election based on Ethereum blockchain. Each deployed contract is an election.

## Installation

1. Clone repository

2. Re-deploy contract to use for each time
    ```javascript
    truffle migrate --reset --network `your network` (re-config your network: mainet, rinkeby at truffle-config.js)
    ```

3, copy folder `contracts` at `build` folder paste to `src` folder
    
4. Run the webpack server for front-end hot reloading (outside the development console). Smart contract changes must be manually recompiled and migrated.
    ```javascript
    // Serves the front-end on http://localhost:3000
    npm run start
    ```

5. Truffle can run tests written in Solidity or JavaScript against your smart contracts. Note the command varies slightly if you're in or outside of the development console.
    ```javascript
    // If inside the development console.
    test

    // If outside the development console..
    truffle test
    ```

6, Test is included for testing React components. Compile your contracts before running test, or you may receive some file not found errors.
    ```javascript
    // Run Jest outside of the development console for front-end component tests.
    npm run test
    ```

7. To build the application for production, use the build command. A production build will be in the build_webpack folder.
    ```javascript
    npm run build
    ```

