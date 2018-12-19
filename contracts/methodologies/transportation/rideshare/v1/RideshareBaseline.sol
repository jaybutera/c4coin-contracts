pragma solidity ^0.4.24;

import "../../../libraries/FixedPointSafeMath.sol";
import "./libraries/BaselineLib.sol";
import "./libraries/EmissionsLib.sol";


/**
 * @title RideshareBaseline
 * @dev This contract stores baseline state
 */
contract RideshareBaseline {

    using FixedPointSafeMath for uint256;

    mapping (address => bool) public baselineCriteria;
    mapping (address => uint256) public baselineEmissions;

    /**
    * @dev Update baseline criteria for a rider
    * @param rider .
    * @param alternativeTransportTime  . (km)
    * @param rideshareTime .
    * @param numRidepools .
    * @param numCommutes .
    * @return Whether the baseline criteria is met
    */
    function setBaselineCriteria(
        address rider,
        uint256 alternativeTransportTime,
        uint256 rideshareTime,
        uint256 numRidepools,
        uint256 numCommutes) public returns (bool) {

        require(rider != address(0));

        baselineCriteria[rider] = BaselineLib.isValidBaseline(
            alternativeTransportTime,
            rideshareTime,
            numRidepools,
            numCommutes
        );

        return baselineCriteria[rider];

    }

    /**
     * @dev Calculates emissions given distance and electric vehicle parameters
     * @param rider Address of rider
     * @param distance Distance traveled by vehicle with occupants (km)
     * @param electricEfficiency Vehicle electric efficiency (kWh/km)
     * @param electricityGenerationEmissions Electricity gen. emissions corresponding to project area (tCO2/kWH)
     * @return Emissions produced in ride (tCO2)
     */
    function setBaselineElectric(
        address rider,
        uint256 distance,
        uint256 electricEfficiency,
        uint256 electricityGenerationEmissions) public returns (uint256) {

        require(baselineCriteria[rider]);

        baselineEmissions[rider] = EmissionsLib.electric(
            distance,
            electricEfficiency,
            electricityGenerationEmissions);

        baselineCriteria[rider] = false;

        return baselineEmissions[rider];

    }

    /**
     * @dev Calculates emissions given distance and fossil-fuel parameters
     * @param rider Address of rider
     * @param distance Distance traveled by vehicle with occupants (km)
     * @param fuelEfficiency Vehicle fossil fuel efficiency (L/km)
     * @param emissionsFactor Emissions factor used for vehicle (tCO2/L)
     * @return Emissions produced in ride (tCO2)
     */
    function setBaselineFossilFuel(
        address rider,
        uint256 distance,
        uint256 fuelEfficiency,
        uint256 emissionsFactor) public returns (uint256) {

        require(baselineCriteria[rider]);

        baselineEmissions[rider] = EmissionsLib.fossilFuel(
            distance,
            fuelEfficiency,
            emissionsFactor
            );

        baselineCriteria[rider] = false;

        return baselineEmissions[rider];

    }

    /**
     * @dev Calculates emissions given distance and fossil-fuel & electric parameters
     * @param rider Address of rider
     * @param distance Distance traveled by vehicle with occupants (km)
     * @param fuelEfficiency Vehicle fossil fuel efficiency (L/km)
     * @param emissionsFactor Emissions factor used for vehicle (tCO2/L)
     * @param electricEfficiency Vehicle electric efficiency (kWh/km)
     * @param electricityGenerationEmissions Electricity gen. emissions corresponding to project area (tCO2/kWH)
     * @param electricRange Vehicle electric range (km)
     * @return Emissions produced in ride (tCO2)
     */
    function setBaselineHybrid(
        address rider,
        uint256 distance,
        uint256 fuelEfficiency,
        uint256 emissionsFactor,
        uint256 electricEfficiency,
        uint256 electricityGenerationEmissions,
        uint256 electricRange) public returns (uint256) {

        require(baselineCriteria[rider]);

        baselineEmissions[rider] = EmissionsLib.hybrid(
            distance,
            fuelEfficiency,
            emissionsFactor,
            electricEfficiency,
            electricityGenerationEmissions,
            electricRange);

        baselineCriteria[rider] = false;

        return baselineEmissions[rider];

    }

}
