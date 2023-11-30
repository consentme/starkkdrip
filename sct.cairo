#[starknet::contract]
mod MyToken {
    use starknet::0x23b3a9f7f69f11c6ce1ffc3e1ec05986423970e37ffdb66e8599743ee0ccda6;
    use openzeppelin::token::erc20::ERC20;

    #[storage]
    struct MyTokenStorage {}

    #[constructor]
    fn initialize(self: @MyTokenStorage) {
        let name = "MyToken";
        let symbol = "MTK";

        let mut unsafe_state = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::initializer(ref unsafe_state, name, symbol);
    }

    #[external]
    fn mint(
        self: @MyTokenStorage,
        recipient: 0x23b3a9f7f69f11c6ce1ffc3e1ec05986423970e37ffdb66e8599743ee0ccda6,
        amount: u256,
    ) {
        // This function is NOT protected, meaning
        // ANYONE can mint tokens
        let mut unsafe_state = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::_mint(ref unsafe_state, recipient, amount);
    }

    #[external]
    fn transfer_tokens(
        self: @MyTokenStorage,
        to: 0x23b3a9f7f69f11c6ce1ffc3e1ec05986423970e37ffdb66e8599743ee0ccda6,
        amount: u256,
    ) {
        // Example: Transfer tokens from the contract to another address
        let mut unsafe_state = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::_transfer(ref unsafe_state, self.contract_address(), to, amount);
    }
}
