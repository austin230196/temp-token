module sbt::sbt;

use sui::{
    coin::{Self, CoinMetadata, TreasuryCap, Coin},
    url
};


public struct SBT has drop {}

const DECIMALS: u8 = 9;
const SYMBOL: vector<u8> = b"SBT";
const NAME: vector<u8> = b"SUI BISON TOKEN";
const DESCRIPTION: vector<u8> = b"";
const ICON_URL: vector<u8> = b"https://f0kcr4xakf.ufs.sh/f/1OiR7T50L4OXYsj4cWVdaEUMHXYzpR1TiI9cwvKP4F3qytmx"; 



fun init(otw: SBT, ctx: &mut TxContext): () {
    let sender = ctx.sender();
    let (treasury_cap, coin_metadata) = coin::create_currency<SBT>(
        otw, 
        DECIMALS, 
        SYMBOL,
        NAME, 
        DESCRIPTION, 
        option::some(url::new_unsafe_from_bytes(ICON_URL)), 
        ctx
    );
    transfer::public_share_object<CoinMetadata<SBT>>(coin_metadata);
    transfer::public_transfer<TreasuryCap<SBT>>(treasury_cap, sender);
}


entry fun mint(cap: &mut TreasuryCap<SBT>, amount: u64, ctx: &mut TxContext): () {
    let coin =coin::mint<SBT>(cap, amount, ctx);
    transfer::public_transfer(coin, ctx.sender());
}


entry fun mint_and_transfer(cap: &mut TreasuryCap<SBT>, amount: u64, recipient: address, ctx: &mut TxContext): () {
    coin::mint_and_transfer<SBT>(cap, amount, recipient, ctx);
}


public fun burn(cap: &mut TreasuryCap<SBT>, coin: Coin<SBT>): () {
    coin::burn<SBT>(cap, coin);
}


// #[test_only]
