				defi and Aave

defipulse & defilama
defipulse ---> is an application that shows some of the top defi projects based on
how much total asset is locked into each protocol 

Aave ----> witch currently is the number one ranked defi application 

Decentralized Exchange (DEX) ---> parasop is what's known as a dex 
it allows us to trade tokens increadibily easy on the blockchain  

borrowing and lending is a critical piece to doing any type of really interesting
financial applications or financial instruments

apy ---> tell you how much precentage over a year you'll actually get in returns
from staking or depositing an asset 

weth gateway ---> that this is the west gateway when we despoit our convent eath it actually get transferred into an erc20 version of our ethereum and then it'll go ahead and deposit it into the ave contract  

ETH gets converted to an ERC10 version of ETH known as Wrapped ETH or WETH

Interest bearing token (aToken) or ae : is what's called an interest-bearing token and goes up in real time 
this number we deposit continually going up : this is the profit given to us from other people borrowing the eath that we've deposited into avee
depositing into aave will give us interest back as a payment for other people borrowing the eath that we've deposited 

we can also use this eath as what's called collateral ---> we can use it to borrow to other asset 

DAI ---> is a commenly used stablecoin
STABLE COINS ---> are tokes that will be "stable" by matching the value of another asset, or being less volitile

Wrapped bitcoin ---> (wBTC) ---> witch represent bitcoin price

									why borrow?

if you borrow an asset and you do not pay attention to how much you have for an underlying collateral you could
get liquidated and lose some of your funds

borrowing tokens --- > if the amount that we borrow ends up being too high we'll actually get what's called liquidated 
---> your health factor must be above 1!
health factor ---> represents how close to being liquidated 
once your health factor reaches one the collateral you've actually deposited will get liquidated and somebody else will get paid to take some of your collateral
the aave application is always solvent 
solvent : the ability to meet debt obligation(means it's never in debt)

choose our health factor rate : stable vs variable
when we borrow an asset we actually have to pay some interest ---> this payment is actually going to go to the people who are depositing dai 
or depositing the asset. the interest rate that we're going to pay is actually going to be paid to those who are depositing the asset that we're borrownig
so like how we're getting interest on our deposited collateral others are getting interest on their deposited collateral based off of how often people are 
borrownig it
stable apy --> witch always be 4%
variable apy ---> witch will change based off of how volatile and how in demand this asset is

****programmatic Interactions with aave

aave doc developers 
--->we're actually not going to deploy any contract because all the contracts that
we're going to work with are already deployed on chain 

1) create aave_borrow.py
1,1 ) converting ETH --> Weth(the erc20 version of eth)
2) create get_weth.py

in kovan etherscan we deposit eth into contract and it transfer us some weath
so we need our script to be able to call deposit contract 
need ABI and ADDRESS

get the WETH interface from lesson 10 source 

aave actually has all these same contracts on the mainnet as well and we know that
we're not going to be working with any oracles 
---> because that we don't actually have to deploy any mocks ourselves --->
we don't have to


we have get_weth func and let's go start borrowing

where we deposit and borrow from in aave is in their contract this lending pool 
the lending pool contract is the main contract for the protocol 

lending pool address can actually change depending on a lot of different pieces
the one func that we need to work with it's this getLendingPoolConfiguration()

we can go to etherscan ave lending pool addresses and copy it in config-brownie

change the imports in IlendingPool.sol interface 
protocol-v2/contracts/protocol/libraries/types/

the interfaces compile down to the abi and we already have the address

erc20 token have an approved function that make sure that  whenever we send a 
token to somebody or whenever a token calls a function that uses our tokens we actually have given them premission to do so

2 ) create approve fun
3 ) create deposit function
we can use the lending pool deposit method

address asset --> erc20 address
uint256 amount ---- > the amount of the token
address onBehalfOf ---> account.address we're depositing this collateral for ourselves 
 uint16 referralCode so the refferal code is ---> 0 --> it is actually deprecated
 and don't actually work anymore and we're just always going pass 0
 
 4) getUserAccountData() ---> get_borrowable_data() 
function getUserAccountData(address user)
all that we need is user's address to get start here

interest rate mode which is going to be stable or variable
5 ) Borrowing DAI
we'll head over to the chain link documentation 
we'll go to ethereum price feeds we'll fine 


Repaying :

repay_all()  ---> first call the approve function to prove that we're going to pay back


1 ) 
