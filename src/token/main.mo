import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";


persistent actor Token {

    transient var owner : Principal =
      Principal.fromText("tlwoa-gcxvo-4m54q-hmdl5-iyvjs-6ek6z-ai5wx-dldon-v4uht-qt7gg-nae");

    transient var totalSupply : Nat = 100_000_000;
    transient var simbol : Text = "DKRI";

    transient var balances = HashMap.HashMap<Principal, Nat>(
        1,
        Principal.equal,
        Principal.hash
    );

    balances.put(owner, totalSupply);
    

    public query func balanceOf(who : Principal) : async Nat {
        let balance = switch (balances.get(who)) {
            case (null) 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSymbol() : async Text {
        return simbol;
    }
};