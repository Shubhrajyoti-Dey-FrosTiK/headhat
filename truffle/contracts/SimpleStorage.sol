// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract SimpleStorage{
    // -----------------------|   ID COUNTER STORE  |--------------------------------------//

    uint public userId;
    uint public roomId;
    uint public eventId;
    uint public transportId;
    uint public serviceId;
    uint public roomBookingId;
    uint public transportBookingId;
    uint public eventBookingId;
    uint public hotelId;

    // -----------------------|   LIST STORE  |--------------------------------------//

    User[] public userList;
    Hotel[] public hotelList;
    Transport[] public transportList;
    Event[] public eventList;

    // -----------------------|   MAPPINGS STORE  |--------------------------------------//
    // UserId -> User mapping 
    mapping(uint => User) public users;

    // UserId -> Service Array consisting of `SERVICE` objects
    mapping(uint => Service[]) public userServices;

    // Service Id -> HostelsMinified Array consists of `HOTEL_MINIFIED` objects
    mapping(uint => HotelMinified[]) public serviceHotels;

    // ServiceId -> Transport Array consisting of `TRANSPORT` objects
    mapping(uint => TransportMinified[]) public serviceTransports;

    // ServiceId -> Event Array consisting of `EVENT` objects
    mapping(uint => EventMinified[]) public serviceEvents;

    // UserId -> RoomBooking Array consisting of `ROOMBOOKING` objects
    mapping(uint => RoomBooking[]) public userRoomBookings;

    // UserId -> TransportBooking Array consisting of `TRANSPORT_BOOKING` objects
    mapping(uint => TransportBooking[]) public userTransportBookings;

    // UserId -> EventBooking Array consisiting of `EVENT_BOOKING` objects
    mapping(uint => EventBooking[]) public userEventBookings;

    // hotelId -> Room Array consisiting of `ROOM` objects
    mapping(uint => Room[]) public hotelRooms;

    // hotelId -> Reviews Array consisiting of `REVIEW` objects
    mapping(uint => Review[]) public hotelReviews;

    // transportId -> Reviews Array consisiting of `REVIEW` objects
    mapping(uint => Review[]) public transportReviews;

    // eventId -> Reviews Array consisiting of `REVIEW` objects
    mapping(uint => Review[]) public eventReviews;


    // ---------------------------|   STRUCT LIST  |--------------------------------------//
    // --| Minified Structs are created in order to save space as well as have a single source of truth  |--//

    /*

        MAPPINGS 
         USER ----- [ID] ----- [ Service ] ---- [ID]  ----- [ HOTEL (For Example) ] -----[ID] -----[ROOM (For Example) ]
         But here there are more layers of information
         [Service] ----- [SERVICE_TYPE (Minified)] -----> Contains the index of <SERVICE_TYPE>list


        Why make list ?? 
         Easier to get all the values at once. 
         One source of truth because of the introduction of MinifiedStructs
         Edits and Delete are easier as to just edit the element at the index
         Delete will just trigger `isActive` to `false` ------> Preserves indexing

        Struct (NORMAL)  V/S  Struct (MINIFIED) -> [As used in HotelMinified, EventMinified, TransportMinified]
         Struct (NORMAL) is a superset of Struct (MINIFIED).
         Struct (MINIFIED) and Struct (NORMAL) only shares those properties which can't be changed once created.
    */

    struct User {
        uint id;
        string name;
        string mobileNo;
        uint loyaltyPoints;
        uint index;
    }

    struct RoomBooking {
        uint id;
        uint userId;
        uint roomId;
        uint checkIn;
        uint checkOut;
    }

    struct TransportBooking {
        uint id;
        uint userId;
        uint transportId;
        bool isCancelled;
    }

    struct EventBooking {
        uint id;
        uint userId;
        uint eventId;
    }

    struct Service {
        uint id;
        uint userId;
        SERVICE_TYPE serviceType;
    }

    enum SERVICE_TYPE{ HOTEL, TRANSPORT, EVENT }

    struct Hotel {
        uint id; // -> not recommended to use this for GET (May be used in future)
        uint userId;
        uint serviceId;
        string name;
        string typeofHotel;
        string location;
        uint index; // DB Indexing for Pipeline
        bool isActive;
    }

    struct HotelMinified {
        uint id; // -> not recommended to use this for GET (May be used in future)
        uint userId;
        uint serviceId;
        uint index; // DB Indexing for Pipeline
    }

    struct Room {
        uint id;
        uint hotelId;
        uint userId;
        uint numOfTotalRooms;
        uint numOfRoomsBooked;
        string roomType;
        string[] roomPics;
        string[] facilities;
        uint index;
    }

    struct Transport {
        uint id;
        uint userId;
        uint serviceId;
        string origin;
        string destination;
        uint startTime;
        uint endTime;
        string transportType;
        uint fare;
        string[] facilities;
        uint index;
        bool isActive;
    }

    struct TransportMinified {
        uint id;
        uint userId;
        uint serviceId;
        uint index;
    }

    struct Event {
        uint id;
        uint userId;
        uint serviceId;
        uint startTime;
        uint endTime;
        uint price;
        string heading;
        string description;
        uint index;
        bool isActive;
    }

    struct EventMinified {
        uint id;
        uint userId;
        uint serviceId;
        uint index;
    }

    struct Review {
        uint id;
        string title;
        string description;
        uint starCount;
    }

    // -----------------------|   Add User  |--------------------------------------//

    function addUser(string memory _name, string memory _mobileNo) public returns(uint) {
        userId++;
        User memory newUser = User(userId,_name,_mobileNo,0,userList.length);
        users[userId] = newUser;
        userList.push(newUser);
        return newUser.id;
    }

    // -----------------------|  Add Bookings [ POST ]  |--------------------------------------//

    function addRoomBooking(uint _userId, uint _roomId, uint _checkIn, uint _checkOut) public returns(uint) {
        roomBookingId++;
        RoomBooking memory newRoomBooking = RoomBooking(roomBookingId,_userId,_roomId,_checkIn,_checkOut);
        userRoomBookings[newRoomBooking.userId].push(newRoomBooking);
        return newRoomBooking.id;
    }

    // function addTransportBooking(uint _userId, uint _transportId) public returns(uint) {
    //     transportBookingId++;
    //     TransportBooking memory newTransportBooking = TransportBooking(transportBookingId,_userId,_transportId,false);
    //     userTransportBookings[newTransportBooking.userId].push(newTransportBooking);
    //     return newTransportBooking.id;
    // }

    function addEventBooking( uint _userId, uint _eventId) public returns(uint) {
        eventBookingId++;
        EventBooking memory newEventBooking = EventBooking(eventBookingId,_userId,_eventId);
        userEventBookings[newEventBooking.userId].push(newEventBooking);
        return newEventBooking.id;
    }

    // -----------------------|   Add Services   |--------------------------------------//

    function addHotel(uint _userId, string memory _name,string memory _typeofHotel, string memory _location, Room[] memory _rooms) public returns (uint) {
        // Incrementing serivceId for uniqueness
        serviceId++;

        // Incrementing hotelid for uniqueness
        hotelId++;

        // Incrementing roomId for uniqueness
        roomId++;

        Service memory newService = Service(serviceId,_userId,SERVICE_TYPE.HOTEL);
        Hotel memory newHotel = Hotel(hotelId,_userId,serviceId,_name,_typeofHotel,_location, hotelList.length,true);
        HotelMinified memory newHotelMinified = HotelMinified(hotelId,_userId,serviceId,hotelList.length);
        uint currentUserId = newService.userId;

         // Updating the hotelId from the room and pushing
        for (uint i = 0; i < _rooms.length; i++) {
            _rooms[i].id = roomId;
            _rooms[i].hotelId = hotelId;
            hotelRooms[hotelId].push(_rooms[i]);
            roomId++;
        }

        // Checking if the same service type exists
        // If exists then change the exisiting object
        // Here we are applying as it is not expensive. At max it will iterate 3 times
        bool serviceTypeFound = false;
        for(uint i=0;i<userServices[currentUserId].length;i++){
            if(userServices[currentUserId][i].serviceType == SERVICE_TYPE.HOTEL){
                serviceTypeFound = true;
                serviceHotels[userServices[currentUserId][i].id].push(newHotelMinified);
                break;
            }
        }

        // If the same service type doesn't exist then
        if(!serviceTypeFound){
            userServices[newService.userId].push(newService);
            serviceHotels[newService.id].push(newHotelMinified);
        }
        
        // Lastly add to the list
        hotelList.push(newHotel);

        // This wil send the serviceId
        return serviceId;
    }

    function addEvent(uint _userId, uint _startTime, uint _endTime, uint _price, string memory _heading, string memory _description) public returns (uint) {
        // Incrementing serivceId for uniqueness
        serviceId++;

        // Incrementing eventId for uniqueness
        eventId++;

        Service memory newService = Service(serviceId,_userId,SERVICE_TYPE.EVENT);
        Event memory newEvent = Event(eventId, serviceId, _userId,_startTime,_endTime,_price,_heading,_description, eventList.length,true);
        EventMinified memory newEventMinified = EventMinified(eventId, serviceId, _userId,eventList.length);
        uint currentUserId = newService.userId;


        // Checking if the same service type exists
        // If exists then change the exisiting object
        // Here we are applying as it is not expensive. At max it will iterate 3 times
        bool serviceTypeFound = false;
        for(uint i=0;i<userServices[currentUserId].length;i++){
            if(userServices[currentUserId][i].serviceType == SERVICE_TYPE.EVENT){
                serviceTypeFound = true;
                serviceEvents[userServices[currentUserId][i].id].push(newEventMinified);
                break;
            }
        }

        // If the same service type doesn't exist then
        if(!serviceTypeFound){
            userServices[newService.userId].push(newService);
            serviceEvents[newService.id].push(newEventMinified);
        }

        // Lastly add to the list
        eventList.push(newEvent);

        // This wil send the serviceId
        return serviceId;
    }

    // function addTransport(uint _userId, string memory _origin,string memory _destination, uint _startTime, uint _endTime, string memory _transportType, uint _fare, string[] memory _facilities) public returns (uint) {
    //     // Incrementing serivceId for uniqueness
    //     serviceId++;

    //     // Incrementing transportId for uniqueness
    //     transportId++;

    //     Service memory newService = Service(serviceId,_userId,SERVICE_TYPE.TRANSPORT);
    //     Transport memory newTransport = Transport(transportId,serviceId,_userId,_origin,_destination,_startTime,_endTime,_transportType,_fare,_facilities,transportList.length,true);
    //     TransportMinified memory newTransportMinified = TransportMinified(transportId,serviceId,_userId,transportList.length);
    //     // Incrementing serivceId for uniqueness)
    //     uint currentUserId = newService.userId;
    //     newService.id = serviceId;
    //     newService.id = transportId;


    //     // Checking if the same service type exists
    //     // If exists then change the exisiting object
    //     // Here we are applying as it is not expensive. At max it will iterate 3 times
    //     bool serviceTypeFound = false;
    //     for(uint i=0;i<userServices[currentUserId].length;i++){
    //         if(userServices[currentUserId][i].serviceType == SERVICE_TYPE.TRANSPORT){
    //             serviceTypeFound = true;
    //             serviceTransports[userServices[currentUserId][i].id].push(newTransportMinified);
    //             break;
    //         }
    //     }

    //     // If the same service type doesn't exist then
    //     if(!serviceTypeFound){
    //         userServices[newService.userId].push(newService);
    //         serviceTransports[newService.id].push(newTransportMinified);
    //     }

    //     // Lastly add to the list
    //     transportList.push(newTransport);

    //     // This wil send the serviceId
    //     return serviceId;
    // }

    // -----------------------|  GET LIST  |--------------------------------------//

    function getHotels() public view returns (Hotel[] memory) {
        return hotelList;
    }

    function getEvents() public view returns (Event[] memory) {
        return eventList;
    }

    // function getTransports() public view returns (Transport[] memory) {
    //     return transportList;
    // }

    function getUsers() public view returns (User[] memory) {
        return userList;
    }

    // -----------------------|  GET by ID [ Slow + shows minified result + Not Recommended (Use Index Shown Below) ]  |--------------------------------------//

    function getHotelById(uint _serviceId, uint _hotelId) public view returns (HotelMinified memory) {
        HotelMinified[] memory userHotels  = serviceHotels[_serviceId];
        HotelMinified memory requestedHotel;
        for(uint i=0;i<userHotels.length;i++){
            if(userHotels[i].id == _hotelId){
                requestedHotel = userHotels[i];
            }
        }
        return requestedHotel;
    }

    function getEventById(uint _serviceId, uint _eventId) public view returns (EventMinified memory) {
        EventMinified[] memory userEvents  = serviceEvents[_serviceId];
        EventMinified memory requestedEvent;
        for(uint i=0;i<userEvents.length;i++){
            if(userEvents[i].id == _eventId){
                requestedEvent = userEvents[i];
            }
        }
        return requestedEvent;
    }

    // function getTransportById(uint _serviceId, uint _hotelId) public view returns (TransportMinified memory) {
    //     TransportMinified[] memory userTransport  = serviceTransports[_serviceId];
    //     TransportMinified memory requestedTransport;
    //     for(uint i=0;i<userTransport.length;i++){
    //         if(userTransport[i].id == _hotelId){
    //             requestedTransport = userTransport[i];
    //         }
    //     }
    //     return requestedTransport;
    // }

    function getUserById(uint _userId) public view returns (User memory) {
        return users[_userId];
    }

    // -----------------------|  GET by Index [ Faster  +  Recommended ]  |--------------------------------------//

    function getHotelByIndex(uint index) public view returns (Hotel memory) {
        return hotelList[index];
    }

    function getEventByIndex(uint index) public view returns (Event memory) {
        return eventList[index];
    }

    // function getTransportByIndex(uint index) public view returns (Transport memory) {
    //     return transportList[index];
    // }

    // -----------------------|  PUT  |--------------------------------------//

    function editHotelByIndex(uint _index, string memory _name, string memory _typeOfHotel, string memory _location) public returns (Hotel memory) {
        Hotel memory updatedHotel = hotelList[_index];
        updatedHotel.name = _name;
        updatedHotel.location = _location;
        updatedHotel.typeofHotel = _typeOfHotel;
        hotelList[_index] = updatedHotel;
        return updatedHotel;
    }

    function editEventByIndex(uint _index, uint _startTime, uint _endTime, string memory _heading, string memory _description) public returns (Event memory) {
        Event memory updatedEvent = eventList[_index];
        updatedEvent.startTime = _startTime;
        updatedEvent.endTime = _endTime;
        updatedEvent.heading = _heading;
        updatedEvent.description = _description;
        eventList[_index] = updatedEvent;
        return updatedEvent;
    }

    // function editTransportByIndex(uint _index, string memory _origin, string memory _destination, uint _startTime, uint _endTime, string memory _transportType, uint _fare, string[] memory _facilities) public returns (Transport memory) {
    //     Transport memory updatedTransport = transportList[_index];
    //     updatedTransport.startTime = _startTime;
    //     updatedTransport.endTime = _endTime;
    //     updatedTransport.origin = _origin;
    //     updatedTransport.destination = _destination;
    //     updatedTransport.transportType = _transportType;
    //     updatedTransport.fare = _fare;
    //     updatedTransport.facilities = _facilities;
    //     transportList[_index] = updatedTransport;
    //     return updatedTransport;
    // }

    // -----------------------|  DELETE  |--------------------------------------//

    function deleteHotelByIndex(uint index) public returns (bool) {
        if(index < hotelList.length){
            hotelList[index].isActive = false;
            return true;
        }else{
            return false;
        }
    }

    function deleteEventByIndex(uint index) public returns (bool) {
        if(index < eventList.length){
            eventList[index].isActive = false;
            return true;
        }else{
            return false;
        }
    }

    // function deleteTransportByIndex(uint index) public returns (bool) {
    //     if(index < transportList.length){
    //         transportList[index].isActive = false;
    //         return true;
    //     }else{
    //         return false;
    //     }
    // }
}