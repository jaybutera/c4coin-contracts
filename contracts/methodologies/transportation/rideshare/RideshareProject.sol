pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "../../abstract/EmissionsStorage.sol";
import "./RideshareToken.sol";


contract RideshareProject is Ownable {
    using SafeMath for uint256;

    RideshareToken co2kn;
    EmissionsStorage baseline;
    EmissionsStorage project;
    /* EmissionsStorage leakage; */

    // Possible to remove all constructor dependencies
    // and initialize all with new...
    // TODO: Make this an initializable fn for ZOS
    // TODO: Should take an owner as input, not implicitly msg.sender as Ownable forces
    constructor (
        RideshareToken _co2kn, // change this to an interface
        EmissionsStorage _baseline,
        EmissionsStorage _project
    ) public {

        co2kn = _co2kn;
        baseline = _baseline;
        project = _project;

    }

    // TODO: Initialize and set additionality storage
    // function Initialize(...)

    // TODO: in future add onlyAdditional modifier
    function mint(address _to) public { // onlyAdditional()

        // Get baseline, project and leakage emissions
        uint256 baselineEmissions = baseline.emissions(_to);
        uint256 projectEmissions = project.emissions(_to);
        uint256 leakageEmissions = 0; // leakage.emissions[_to];

        // Verify emissions were reduced
        require(baselineEmissions > projectEmissions + leakageEmissions);
        require(projectEmissions > leakageEmissions);

        // Calculate emissions reductions
        uint256 emissionReductions = baselineEmissions.sub(projectEmissions).sub(leakageEmissions);

        co2kn.mint(_to, emissionReductions);
    }
}
