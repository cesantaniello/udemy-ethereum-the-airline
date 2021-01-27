pragma solidity ^0.4.24;

contract Airline{

    address public owner;

    struct Customer {
        uint loyaltyPoints;
        uint totalFlights;
    }

    struct Flight {
        string name;
        uint256 price;
    }

    Flight[] public flights;

    mapping(address => Customer) public customers;
    mapping(address => Flight[]) public customersFlights;
    mapping(address => uint) public customersTotalFlights;

    event FlightPurchased(address indexed customer, uint price);

    constructor(){
        owner = msg.sender;
        flight.push(Flight('Tokio', 4 ether));
        flight.push(Flight('Germany', 1 ether));
        flight.push(Flight('Madrid', 2 ether));
    }

    function buyFlight(uint flightIndex) public payable {
        Flight flight = flights[flightsIndex];
        require(msg.value == flight.price);

        Customer storage customer = customers[msg.sender];
        customer.loyaltyPoints += 5;
        customer.totalFlights += 1;
        customerFlights[msg.sender].push(flight);
        customersTotalFlights[msg.sender] ++;

        FlightPurchased(msg.sender, flight.price);
    }
}