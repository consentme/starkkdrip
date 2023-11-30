#[starknet::contract]
mod MyToken {
    use starknet::0x0604252093b2ba39c571b3e66fc60233619b61a8a6040d740ff2bfad46959e10;
    use openzeppelin::token::erc20::ERC20;

    #[storage]
    struct MyTokenStorage {}

    #[constructor]
    fn initialize(
        self: @MyTokenStorage,
        initial_supply: u256,
        recipient: 0x23b3a9f7f69f11c6ce1ffc3e1ec05986423970e37ffdb66e8599743ee0ccda6,
    ) {
        let name = "MyNewToken";
        let symbol = "MNT";

        let mut unsafe_state = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::initializer(ref unsafe_state, name, symbol);
        ERC20::InternalImpl::_mint(ref unsafe_state, recipient, initial_supply);
    }
}
