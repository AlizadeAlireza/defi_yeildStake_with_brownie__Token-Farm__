// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface tokenRecipient {
    function receiveApproval(
        address _from,
        uint256 _amount,
        address _token,
        bytes calldata _extraData
    ) external;
}

contract TokenERC20 {
    // public
    string public name;
    string public symbole;
    uint8 public decimals = 18;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // event
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _amount
    );
    event Burn(address indexed from, uint256 amount);

    constructor(
        uint256 initialSupply,
        string memory tokenName,
        string memory tokenSymbol
    ) {
        totalSupply = initialSupply * 10**uint256(decimals); // update totalSupply
        balanceOf[msg.sender] = totalSupply; // tokens
        name = tokenName;
        symbol = tokenSymbol;
    }

    // functions
    function _transfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal {
        // balanceOf[from] -= amount;
        // balanceOf[to] += amount;
        require(_to != address(0x0));
        require(balanceOf[_from] >= _amount);
        require(balanceOf[_to] + _amount >= balanceOf[_to];)
        uint256 previousBalances = balanceOf[_from] + balanceOf[_to];
        // update amounts
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
        
        emit Transfer(_from, _to, _amount);
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);

    }

    function transfer(address _to, uint256 _amount) public returns (bool seccess) {
        _transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) public returns (bool seccess) {
        // impelement taking funds from a user
        require(_amount <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _amount;
        _transfer(_from, _to, _amount);
        return true;
    }

    function approve(address _spender, uint256 _amount) public returns (bool seccess) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function approveAndCall (
        address _spender, 
        uint256 _amount,
        bytes memory _extraData
    ) external returns (bool seccess) {
        tokenRecipient spender = tokenRecipient(_spender);
        if(approve(_spender, _amount)) {
            spender.receiveApproval(nsg.sender, _amount, address(this), _extraData);
            return true;
        }
    }

    // irreversibly

    function burn(uint256 _amount) external returns(bool success) {
        require(balanceOf[msg.sender] >= _amount);
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Burn(msg.sender, _amount);
        return true;
    }

    function burnFrom(address _from, address _amount)
    external
    returns (bool seccess) 
    {
        require(balanceOf[_from] >= _amount);
        require(_amount <= allowance[_from][msg.sender]);
        balanceOf[_from] -= _amount;
        allowance[_from][msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Burn(_from, _amount)
        return true;
        
    }

    function mint(uint _amount) external {
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
        emit Transfer(msg.sender, address(0), _amount);
    }
}
