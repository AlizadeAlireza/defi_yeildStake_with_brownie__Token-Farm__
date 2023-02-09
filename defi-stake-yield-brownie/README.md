what this application is going to allow users to stake or deposit their 
tokens into what's called ---> token farm contract 

there's a many feature that we can do when the users depost their tokens

we can do is as admins of this wallet we can actually issue a reward to our users
based on how much they've staked 

on the backend i'm going to run an issue token script it's going to send all users
that have some stake a little bit of a dap token reward 

*** we're not going to go over the unstaking portion of front end app.

DappToken.sol ---> this is going to be the token that we're going to give out
to users who are staking on our platform ----> regular old ERC20

func stakeTokens():
 we want to stake amount and the address
 for our app we can stake any amount greater than zero
 
 from who ever calls stake tokens to this tokenfarm contract and we'll send
 the amount 
 
 with 0.8.0 ---> don't worry about safe math
 we only want certain specific tokens to be staked on our platform
 
 
 func tokenIsAllowed() : the address of token deposit must be supported token from our Dapp
 
 now we have a way to check to see if allowed tokens are there let's actually 
 write a function to add allowed tokens 
 --> addAllowedTokens -> onlyOwner
 
 now start checking to see if tokens that these stakers are going to stake
 is allowed? 
 require statement.
 
 we use transferFrom since our token farm contract isn't the one that owns the 
 erc20 and need to abi to call this transferFrom function 
 so we need IERC20 interface
 
 
 we need to track how actually token send us . ---> create mapping 
 
 
 
 issueTokens() --> is a reward we're giving to the users who use our platform:
 so we want to issue some tokens based off the value underlying that they've 
 given us
 control only by admin 
 loop through the list of all the stakers that we have and shoud make it!!!
 
 when somebody stakes a token we're going have to update this list.
 we want to make sure they're only added if they're not already on the list.
 for do this we should get an idea of how many unique tokens a user actually has.
 
 ---> create updateUniqueTokensStaked():
 	it's going to get a good idea of how many unique tokens a user has.
 	if a user has one unique token we can add them to list.
 	if they have more than 1 we know that they've already been added to
 	the list so we don't need to add them there
 	
 update some unique tokens staked mapping
 
 better idea:
each one of these users has staked what we can do is we can figure out wether or not we want to push them onto this stakers list.if already on there we don't want to push them on there.
loop through this list of stakers 

***we have to send them a token reward we have to figure out how to actually 
send them this token and then we also have to get their total value locked.

the reward ---> DAPP token
need to know what a reward token is actually going to be 
so we need to create a constructor and we'll store this dap token as a global 
variable.
now we have this dap token with its associated address ---> call functions on
how much we must send to them? need some function to get the total value

uint userTotalValue = we name that func ---> getUserTotalValue() 
we gotta find out how much each of these tokens actually has

a lot of protocols do instead of actually them sending and them issuing the tokens 
is they actually just have some internal methods that allows people to go 
and claim their tokens like claiming airdrops.
because it's a lot more gas efficient to have users claim the airdroped istead 
of the application actually issuing the tokens ---> very gas expensive to do
looping through all these addresses and checking all these addresses.


after allowed tokens and we're going to find how 
if they have some token staked we'll go ahead and find it.
so we're going loop through those allowed tokens and we're going find how much 
this user has for each one of these allowed tokens.

after creating loop let's go ahead and we'll add the total value
totalValue = total value + ; // however much value this person has in these tokens in this single tokens


getUserTotalValue() is the total value across all the different tokens.
we need a way to get the total value across one token.

-------------------------------------------------------------------------

for this we need to create a new function ---> getUserSingleTokenValue(_user) 
and pass it the single token that we're on right now --> allowedTokens[allowedTokenIndex]

create function getUserSingleTokenValue ---> get address of the user and an address of a token

we want to get value of how much this person staked of this single token to 
convertion  exactlyl how much value this person has staked in our app.

we don't use require here because we want to actually keep going,
if this is zero we don't want the transaction revert, want keep going.

how to get value of a single token?
- need staking balance 
- price of that token
# price of the token * staking balance[_token][_user]

------------------------------------------------------------------

for this we need to a new Func ---> getTokenValue(_token)

get chainlink once again.

we're going to actually have to map each token to their associated price feed addresses.

mapping (address => address) public tokenPriceFeedMapping;
---> map the token to their associated price feeds.

so we're going to have to a function ---> setPriceFeedContract()
it is only owner.
we don't want anybody to be able to set the priceFeed.

we get the priceFeed address from _token argument that is the _token address in tokenPriceFeed mapping.

after import chainlink interface we can grab that.

we need to know how many decimals the price feed contract has,
that way we can match everything up to be using the same units.

so now we scrolling back and adding all this stuff in uint.

so our staking balance is going be in 18 decimals so it's going to be 
1000000000000000000
and multiply in eth/usd -> 100(00000000) and devide on 10 ** decimals,
decimal for eth/usd

for this math operation we need test.it's necessary.

finish func getUserTotalValue with return totalValue;

then we can pull up to our issue tokens.

now that we have the total value that this user that actually logged we can 
just transfer the amount of tokens that they have in total value.

we'll say however mush they have in total value staked on our platform and
we'll issue them as a reward.

stakeTokens - DONE!!!
issueTokens - DONE!!!
getValue - DONE!!!
addAllowedTokens - DONE!!!
unStakedTokens - ?

-------------------------------------------------------------------------

the first thing we want to do in this function is fetch staking balance.
second is require for balance > 0.
third is transfer.

once we transfer the token we'll do staking balance of this token of msg.sender and we're going to update this balance to zero.(entire balance here)

then we're going to update how many of those unique tokens that they have.

can this be reentrancy attack????!!!!!

last thing is that we could do is update our stakers array to remove this person
no longer anythings staked 


*** issue tokens function going to check to see how much they actually have staked and if they don't have anything staked then they're not going to get sent
any tokens.


-------------------------------------------------------------------------------

brownie:

dapp token takes one parameter witch is dapp token address to give reward

once we've deployed this tokenFarm contract we need a couple things:
- need to send this some dapp tokens as a reward.

we can only stake tokens that are allowed and each one of this tokens also is 
going to need to have some price feed assosiated.

add_allowed_tokens(token_farm, dict_of_allowed_tokens, account)
1. need to call add alowed function
2. a dictionary of the different token addresses and their assosiated price feeds
3. we need an account 

need the address of the different tokens that we want to have 
how to get addresses of different tokens?

for add tokens we can do it in our config 

what we put in get_contract needs to match our string in our config 
and we can create our mock and declare them into contract_to_mock.

in mock_deploy clear coordinator and oracle and instead we'll deploy those 
that mock weth and mock DAI

we have address of fau and weth token and if those don't exist on the network we're working on we're going to deploy a mock so.
now we have addresses we can do a dictionary of allowed tokens is going to be equal to this dictionary tath we make.

we're just going to wrap each one of these contracts like the dapp token

we need dai and eth usd price feed ---> in the kovan

we can pass the dictionary to the add allowed tokens 
-- > will map the tokens and their addresses with their associated price feeds
so we can get them all to equal the same value in our contracts.

in add_allowed_tokens() we're going to loop through all these different tokens 
and call the add allow tokens functino on it.
--------------------------------------------------------------
-----------------------------------------------------------------
now it's time to run some test:

ideally every piece of code in our smart contract should be tested in some form.

make sure we are on local network.
test_set_price_feed_contract():
in mapping _priceFeed sould now be updated and this is address to address.

another thing is to make sure non_owners can't call this function
that expecting this contract call to actually revert.

		++++++	++++++	++++++	++++++	++++++	++++++
test_issueTokens():
in order to test issuing tokens we actually need to stake some tokens first.

		++++++	++++++	++++++	++++++	++++++	++++++
test_stake_tokens():

act -> actually send some tokens to our token farm.first need to call dapp_token

we're going to costly be using an amount staked for a lot of our test here.

we're going to create our first fixture 	
now we can use this amount staked fixture as basically a static variable.

pytest and brownie will grab all conftest stuff and put it into a function as
an argument.
for stakingBalance -> we need pass two variables :
- first address
- second address 
to get the amount of staking.
token_farm.stakingBalance(dapp_token.address, account.address) == amount_staked

so in this line of code we pass token address of the user address that stake
balance.
and in amount stake that deposit 1 ether....the amount staked must be equal to 1.

 
		++++++	++++++	++++++	++++++	++++++	++++++
		
test_issue_tokens():
use amount staked parameter 
istead  token_farm, dapp_token = deploy_token_farm_and_dapp_token()
we going to do ->
 token_farm, dapp_token = test_stake_tokens(amount_staked)
 
 this is why we return token_farm and dapp_token in our test stake token
 
 we should have done our testing already on the things like getUserTotalValue()
 because it's a subset of issue tokens 
 
		=======================================================
		
for front end we use type script, react and useDapp

useDapp : it's a framework for rapid dap development and works great with react


first ---> create react app boilerplate
install npm
install yarn

it is better to have a front end repo seprate from your contracts

in front_end folder:

node_modules : project dependecies like pip ---> packages
Public : static Images and files
src : we working with a lot.

start:
cd front_end
$ yarn ---> to make sure everything installed

yarn is going to go out and download these dependencies and store them into 
node modules and yarn.lock is going to tell us exactly what it downloaded.

we want to work with useDapp.
after setting DAppProvider we must add config
 
at the first bracket we're going to type TS.
and the second bracket we're an object here.

header component --> where we put modular parts of our front-end
use materials ui
from materials we're going to use what's called containers --> allows us to style

add main.tsx in components

in the stake form:
	- our wallet balance 
	- big stake button
	
WalletBalance ---> reading offchain finally after a lot of ts and react setup
we can provides a way to fetch the balance of erc20 tokens specifide by a token address

for stake and interact with the contract we need to create another component.
we're going to create a stake form with a big button that says stake and 
the user can actually choose how much they want to stay on our smart contract.

we want it to stake that amount and we also need to have some type of form
here we need to know how much we want to stake right

send that amount as part of our stake

how to call this approve function here? we're actually going to make new state hooks.

if already been approved if it's not already been approved and what we need to do?
- we need some approved thing
- stake tokens thing 
for approave we need address, abi and chainId.

useContractFunction --> it's a hook in use dap that returns an object with two 
variables ---> state and send.
state : used to represent the status of the transaction --> automatically kickoff
the stake after we approve 

send: to send a transaction we have to actually to use send function.

useEffect: is allows us to do something if some variable has changed.
one of these things that we want to track is erc20 stake.
if successful we want to do some stuff.

notifications:
help us actually get notified on whether or not our transactions are completing.


Alerts:
