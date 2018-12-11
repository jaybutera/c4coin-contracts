pragma solidity 0.4.24;

import "./EnumVehicleTypes.sol";
import "../abstract/EmissionsReduction.sol";


contract RideshareEmissions_V1 is EnumVehicleTypes, EmissionsReduction { // is Initializable

    modifier isValidFossilFuelBaseline(bytes data) {
        // how do we verify?
        _;
    }

    modifier isValidElectricBaseline(bytes data) {
        // how do we verify?
        _;
    }

    modifier isValidHybridBaseline(bytes data) {
        // how do we verify?
        _;
    }

    function _baselineEmissionsFossilFuel(
        uint32 distance_km,
        uint32 efficiency_liters_per_km,
        uint32 emissions_factor_metric_tons_co2_per_liter) private pure
        isValidFossilFuelBaseline(data) returns (uint256) {

        // fixed point multiply...

        return 0;
    }

    function _baselineEmissionsElectric(bytes32 data) private pure
        isValidElectricBaseline(data) returns (uint256) {

        // enum VehicleType PEV Electric
        // Electric efficiency (kWh/km) = W_c
        // Electricity generation GHG emission factor corresponding to project community area
        //    adjusted for transmission loss, if available (tCO2e/kWh)  = GE_p

        return 0;
    }

    function _baselineEmissionsHybrid(bytes32 data) private pure
        isValidHybridBaseline(data) returns (uint256) {

        // enum VehicleType PHEV / Hybrid
        // max(0, D_i-R_c)*V_c*EF_f + min(D_i, R_c)*W_c*GE_p
        // R_c = vehicle all electric range (km)
        // W_c = Vehicle electric efficiency for SOBT vehicle (kWh/km)
        // GE_p = Electricity generation GHG emission factor corresponding to project community area
        //       adjusted for transmission loss, if any (tCO2e/kWh)
        // V_c = Vehicle fossil fuel efficiency for SOBT vehicle  (L/km)
        // EF_f = GHG emission factor of fuel used by vehicle (tCO2e/liter)

        return 0;
    }

    function baselineEmissions(bytes data) public pure returns (uint256) {

        // uint256 vehicleType,
        // require(isValidVehicleType(vehicleType));
        VehicleTypes v = VehicleTypes(vehicleType);
        if (v == VehicleTypes.FossilFuelVehicle) {
            return _baselineEmissionsFossilFuel(data);
        } else if (v == VehicleTypes.ElectricVehicle) {
            return _baselineEmissionsElectric(data);
        } else {
            return _baselineEmissionsHybrid(data);
        }

        // baseline formula -- has a require(isAdditional())
        //    doees the person have a car?
        //    how frequently do they use that car? HHI arguement
        //    keep trakc of number of ride shares, how many miles do they commute a year?
        //    will only work if they register their car, so you can keep track of commute counts?
        // /  we have to determine if they use that to commute the majority of the time
        //    what about being over median ratio of rideshare miles / distance miles
        // how do you prove cyclic activity? if same people ride share?
        //   don't you need a max miles per day in additinality criteria?
        //   if you have the choice to rideshare or not when traveling and hyou choose to
        //   rideshare isn't it already additional? if you have a max alloc?
        //
        //   one the way traveling vs out of way traveling
        //   if on the way easy to divide, if out of the way, gotta take into account
        //   route... need to know distance each would cover... and what car would be used
        //
        //   since the 'what car would be used' is kind of a stochastic / random
        //   take the citites average efficiency, basically how many FFV, what type, etc.
        //
        //   baseline is sigma distance that would've been traveled * average emissions factor per participant
        //   pe is actual distance times actual (require pe_distance < sigma )
        //   le - change in average emissions factor

    }

    function projectEmissions(bytes data) public pure returns (uint256) {
        // uint256 vehicleType,

        // project emissions formula
        // leakage formula
        //
        // running average weekly baseline
        // what would have occured if rideshare not taken, if done solo
        //
        // project emissions
        // Electric d * W_c * GE_p
        // W_c = electric efficiency of vehicle (kWH/km)
        // GE-p = electricity gen. GHG emissions factor in community area p (tCO2e/kWh)
        //
        // FFV - OBDII measurement
        // PE_j_c = FC_j_c * EF_f(c)
        //
        // EF_c = emissions fuel factor tCO2e /liter
        // FC_j_c = measure fuel consumption (cubic feet or natural gas) (liters)
        // if no OBD II is available then use the following formula:
        //
        // PE_j_c = d_j * V_c * EF_f_c
        //
        // V_c =  Vehicle fossil fuel efficiency of a carpool vehicle  (L/km)
        // EF_f_c = GHG emission factor of fuel used by vehicle (tCO2e/L)
        //
        // Hybrid PHEV
        // FC_j_c * EF_f_c + min(dj, max(0, R_c -dd_j_c)) * W_c * GE_p <--
        // dd_j_c cumulative distance traveled
        // R_c vehicle all electric range
        // FC_j_c = measure fuel consumption (L)
        // EF_f_c emissions fuel factor
        //
        // use this formula: p 20
        //
        return 0;
    }

    /**
     * 0
    **/
    function leakageEmissions(bytes data) public pure returns (uint256) {
        return 0;
    }
