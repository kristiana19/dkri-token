import React from "react";
import { token } from "../../../declarations/token"
import { useState } from "react";

function Faucet() {

  const [isDisabled, setDisabled] = useState(false);
  const [buttonText, setButtonText] = useState();

  async function handleClick(event) {
    setDisabled();
    const result = await token.payOut();
    setButtonText(result);

  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free DKristijana tokens here! Claim 10,000 DKRI coins to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" 
        onClick={handleClick}
        disabled={isDisabled}
        > Gimme gimme
        </button>
      </p>
    </div>
  );
}

export default Faucet;
