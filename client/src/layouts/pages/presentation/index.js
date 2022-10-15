/*
=========================================================
* Material Kit 2 React - v2.0.0
=========================================================

* Product Page: https://www.creative-tim.com/product/material-kit-react
* Copyright 2021 Creative Tim (https://www.creative-tim.com)

Coded by www.creative-tim.com

 =========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*/

// Material Kit 2 React pages
import Presentation from "pages/Presentation";
import { useEffect } from "react";
import useEth from "../../../contexts/EthContext/useEth";

export default function PresentationPage() {
  const {
    state: { contract, accounts },
  } = useEth();

  const read = async () => {
    const loginStatus = await contract.methods
      .getUserLoginStatus()
      .call({ from: accounts[0] });
    console.log(loginStatus);
    if (!Number(loginStatus)) {
      const createUser = await contract.methods
        .addUser("SD", "Hello")
        .send({ from: accounts[0] });
      console.log(createUser);
      console.log("User should be created");
    } else {
      console.log("User exists");
    }

    // const value = await contract.methods
    //   .getUserLoginStatus()
    //   .call({ from: accounts[0] });
    console.log(contract);
  };

  useEffect(() => {
    if (contract) read();
  }, [contract]);
  return <Presentation />;
}
