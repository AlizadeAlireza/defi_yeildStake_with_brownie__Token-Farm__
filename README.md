# WHAT IS ERC20

ERC : Ethereum Request for Comments

20 : is just the number they assigned to a proposal.

this tokens exist on the Ethereum platform and that in itself consists out of a blockchain that is
capable of storing transactions and a virtual machine that is capable of running smart contracts.

tokens live on the Ethereum blockchain.
they aren't independent and rely on Ethereum's blockchain and platform.

beside Ether, it can support other tokens and these can work like currencies.
they can also represent shares of a company, loyalty points, gold certificates and ...

ERC20 is a guideline ro standard for when we want to create our own token.

## ERC20 examples:

    tether, chainlink, unitoken, dai

    chainlink is ERC677 as there are upgrade to the ERC20

## HOW A ERC20 Token CREATED

a token can be created by smart contract.

this contract despite of creating tokens also:

    - managing transaction
    - keep tracking of each tokens holder's balance.

when we want to create our own token, we wirte a smart contract that can create tokens,
transfer them and keep track of people's balances.

If we want our token to be an ERC20 token, we have to implement the ERC20 interface.

## Get Token

to get some tokens we have to send some Ether to the smart contract, which will the give us a certain amount of tokens in return.

## Tokens Exchange

each token contract can be completely different from the other.
so if we want our token be available on an exchange, the exchange has to write custom code,
so they can talk to our contact and allow people to trade.

the same thing goes for wallet providers.

this will be very difficult for hundred of tokens and be very complex and time consuming.

so instead, the community proposed a standard called ERC20.

so everyone who wanted to create a token had to reinvent the wheel and that means:

    each token contract was slightly different and that exchanges in wallets had to write custom code
    to support our token.

but in ERC20 however exchanges and wallet providers only have to implement this code once and
that's why exchanges can add new tokens so quickly and why wallets have support for all ERC20 tokens, without having
to updated.

## Function and Implement

it defines 6 mandatory functions that our smart contract should implement and 3 optional ones.

### optionally:

    - name : "Alireza"

    - symbol : "ALZ"

    - decimals : 8
    how dividable our token is by specifying how many decimals it should supports.

### mandatory:

    - totalSupply of our token:
        when this limit is reached, the smart contract will refuse to create new tokens.

    - balanceOf:
        return how many tokens a given address has.

    -transfer:
        takes a certain amount of token from the totalSupply and gives them to a user.

        the holder of the ERC20 token can call the function transfer to transfer
        his ERC20 token over to a recipient.

        transfer the amount of token that msg.sender has over to a recepient.

    -transferFrom:
        can be used transfer tokens between any two users who have them.

        once a holder approve another spender to transfer his token,
        then the spender can call the function transferFrom():

            - transfering from the holder to another recipient for the amount.

        transfer some token from sender to recipient for the amount from the input.
        can call as long as the sender has approved msg.sender to spend his token.

    - approve:
        verifies that our contract can give a certain amount of tokens to a user,
        taking into account the totalSupply.

        instead of calling transfer directly (in transfer() function),
        the holder can allow another spender to send his token on his behalf can
        call approve() and approving the sender to spend some of token.

    -allowance:
        like approve except that it checks if one user has enough balance to send a certain amount of tokens to
        someone else.

        how much is a spender allowed to spend from a holder, we can find it with allowance().

        the caller is allowing the spender to spent amount of his token.

    - mint:
        create new tokens.

        whoever deploys this contract will own all the tokens to start.
        then we'll give it totalSupply.

    - burn:
        means destroy the tokens form circulation.

        basically it's sent to an address that no one hat the private key of

## ERC20 Not Perfect itself

it's only a guidline and people are free to implement the required functions however they like.
that has lead to some interesing problems.

    to buy some tokens we have to send Eth to the token contract.
    some people tried to sending other ERC20 tokens instead.
    if the contract was not designed with this in mind, tokens being lost.

for solve this, the community is already working on extending the ERC20 standard with ERC223.

## implementing in code:

    - when we mint tokens the total supply will increase
    and when we burn tokens the totalSupply will decrease.

    - how much each user has a token
    mapping (address => uint)

    - for approve to sender to spend some of his token on his behalf,
    we need to save that in a state variable.

transfer():

    - in this after call we need to update balanceOf.
    - after update we need to emit.
    - last thing is return a bool.

approve():

    - can approve a spender to spend some of his balance.
    - we need to emit event.

transferFrom():

    - we need to detuct after spend the token from msg.sender that approved from spender.
    - after transfering token we need to update balanceOf.
    - after all this we need to emit Transfer.

mint():

    - when we generate new tokens we need to update the balance of the caller.
    - after the new tokens generated we need to update the totalSupply().
    - emit the Transfer:

        when we creating new tokens we don't transfer from any account,
        so we put address(0).
