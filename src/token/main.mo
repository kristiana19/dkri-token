import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";


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
    };

    public shared(msg) func payOut() : async Text {
        //Debug.print(debug_show(msg.caller));
        if(balances.get(msg.caller) == null) {
            let amount = 10000;
            balances.put(msg.caller, amount);
            let result = await transfer(msg.caller, amount);
            return result;
        } else {
            return "Already Claimed"
        };
    };

    public shared(msg) func transfer(to: Principal, amount: Nat) : async Text {
        let fromBalance = await balanceOf(msg.caller);
        if(fromBalance > amount) {
            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount; 
            balances.put(to, newToBalance);

            return "Success";
        } else {
            return "Insufficient Funds";
        }
        
    }
};