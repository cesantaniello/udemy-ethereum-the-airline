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

    uint etherPerPoint = 0.5 ether;

    Flight[] public flights;

    mapping(address => Customer) public customers;
    mapping(address => Flight[]) public customersFlights;
    mapping(address => uint) public customersTotalFlights;

    event FlightPurchased(address indexed customer, uint price);

    constructor(){
        owner = msg.sender;
        flights.push(Flight('Tokio', 4 ether));
        flights.push(Flight('Germany', 3 ether));
        flights.push(Flight('Madrid', 3 ether));
    }

    function buyFlight(uint flightIndex) public payable {
        Flight storage flight = flights[flightIndex];
        require(msg.value == flight.price);

        Customer storage customer = customers[msg.sender];
        customer.loyaltyPoints += 5;
        customer.totalFlights += 1;
        customersFlights[msg.sender].push(flight);
        customersTotalFlights[msg.sender] ++;

        FlightPurchased(msg.sender, flight.price);
    }

    function totalFlights() public view returns (uint) {
        return flights.length;
    }

    function redeemLoyaltyPoints() public {
        Customer storage customer = customers[msg.sender];
        uint etherToRefund = etherPerPoint * customer.loyaltyPoints;
        msg.sender.transfer(etherToRefund);
        customer.loyaltyPoints = 0;
    }

    function getRefundableEther() public view returns (uint){
        return etherPerPoint * customers[msg.sender].loyaltyPoints;
    }

    function getAirlineBalance() public isOwner view returns (uint) {
        address airlineAddress = this;
        return airlineAddress.balance;
    }

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
}