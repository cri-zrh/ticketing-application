dtmc
//model of a location based mobile ticketing application

//variables
const int start_user = 1; //position user are starting their journey (0-15)
const int end_user = 15; //position user plan to end their journey (0-15)
const int start_route = 0; //position public transport starts (0-15 & has to be smaller or equal to start_user)
const int end_route = 15; //position public transport ends (0-15 & has to be bigger or equal to end_user)

const int start_zone1 = 2; //position zone 1 starts (1-15, and has to be smaller or equal to end of zone 1 and to end of all other zones)
const int end_zone1 = 5; //position zone 1 ends (1-15, hast to be bigger or egual to start of zone 1 and has to be smaller than all other zones)
const int start_zone2 = 6; //position zone 2 starts (1-15, and has to bigger than end of zone 1)
const int end_zone2 = 8; //position zone 2 ends (1-15, and has to be bigger or equal to start of zone 2, bigger than end of zone 1 and smaller than start of zone 3)
const int start_zone3 = 9; //position zone 3 starts (1-15, and has to be bigger than end of zone 2)
const int end_zone3= 12; //position zone 3 ends (1-15, has to be bigger or equal to start of zone 3 and bigger than all other zones)

const double phone_fail_input = 0.001;
const double phone_fail = (phone_fail_input * (end_user-start_user)); //probability user's phone stops working
const double gsm_fail = 0.1; //probability gsm can't locate phone
const double wifi_fail = 0.1; //probability wifi can't locate phone
const double gps_fail = 0.33; //probability gps can't locate phone
const double no_checkin = 0.001; //probability of user forgetting to check-in 

const double a; //average accuracy for localisation is correct
const double m_a = 1 - a; // 1- average accuracy for localisation. Variable only used to facilitate calculations


//labels
label "phone_failure" = t=3;
label "forget_checkin" = u=3;
label "gsm_failure" = t=6;
label "wifi_failure" = t=8;
label "gps_failure" = t=10;
label "localisation_failure" = t=12;
label "zone1_correct" = z1=2;
label "no_localisation_zone1" = z1=3;
label "zone2_correct" = z2=2;
label "no_localisation_zone2" = z2=3;
label "zone3_correct" = z3=2;
label "no_localisation_zone3" = z3=3;


//model
module User_position

//model user movement and take in account how accurate measurement will be
//p=0:start, p=1:position1 ... p=15:position15

p:[start_route..end_route] init start_user;

[get_u_pos] p=0 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=0) + (2*(m_a/6)):(p'=2) + (m_a/6):(p'=0) + (m_a/6):(p'=3) + a:(p'=1); //user moves from position 0 to 1 and is located in 1 with probability a. But might also be located in 0,2 or 3.
[] p=end_user -> (p'=end_user); //check if user reached end of their journey, if yes terminate with loop
[get_u_pos] p=1 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=1) + (2*(m_a/6)):(p'=3) + (m_a/6):(p'=0) + (m_a/6):(p'=4) + a:(p'=2);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=2 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=2) + (2*(m_a/6)):(p'=4) + (m_a/6):(p'=1) + (m_a/6):(p'=5) + a:(p'=3);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=3 & t=0 & u=4 & !p=end_user  -> (2*(m_a/6)):(p'=3) + (2*(m_a/6)):(p'=5) + (m_a/6):(p'=2) + (m_a/6):(p'=6) + a:(p'=4);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=4 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=4) + (2*(m_a/6)):(p'=6) + (m_a/6):(p'=3) + (m_a/6):(p'=7) + a:(p'=5);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=5 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=5) + (2*(m_a/6)):(p'=7) + (m_a/6):(p'=4) + (m_a/6):(p'=8) + a:(p'=6);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=6 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=6) + (2*(m_a/6)):(p'=8) + (m_a/6):(p'=5) + (m_a/6):(p'=9) + a:(p'=7);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=7 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=7) + (2*(m_a/6)):(p'=9) + (m_a/6):(p'=6) + (m_a/6):(p'=10) + a:(p'=8);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=8 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=8) + (2*(m_a/6)):(p'=10) + (m_a/6):(p'=7) + (m_a/6):(p'=11) + a:(p'=9);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=9 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=9) + (2*(m_a/6)):(p'=11) + (m_a/6):(p'=8) + (m_a/6):(p'=12) + a:(p'=10);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=10 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=10) + (2*(m_a/6)):(p'=12) + (m_a/6):(p'=9) + (m_a/6):(p'=13) + a:(p'=11);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=11 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=11) + (2*(m_a/6)):(p'=13) + (m_a/6):(p'=10) + (m_a/6):(p'=14) + a:(p'=12);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=12 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=12) + (2*(m_a/6)):(p'=14) + (m_a/6):(p'=11) + (m_a/6):(p'=15) + a:(p'=13);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=13 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=13) + (2*(m_a/6)):(p'=15) + (m_a/6):(p'=12) + (m_a/6):(p'=15) + a:(p'=14);
[] p=end_user -> (p'=end_user);
[get_u_pos] p=14 & t=0 & u=4 & !p=end_user -> (2*(m_a/6)):(p'=14) + (2*(m_a/6)):(p'=15) + (m_a/6):(p'=13) + (m_a/6):(p'=15) + a:(p'=15);
[] p=end_user -> (p'=end_user);
[] p=end_route -> (p'=end_route); //end of route, terminate with loop

endmodule


module Ticketsystem

//model of ticketsystem that takes into account that user's phone or any of the 3 localisation techniques might fail.
//t=0: init, t=1:start, t=2:working phone, t=3:no phone, t=4:start localisation, t=5:gsm working, t=6:gsm not working, t=7:wifi working
//t=8:wifi not working, t=9:gps working, t=10:gps not working, t=11:successful localisation, t=12:no data available

t:[0..12] init 0;

[get_u_pos] t=0 -> (t'=1); //start localisation on synchronisation
[] t=1 -> (1-phone_fail):(t'=2) + phone_fail:(t'=3); // user's phone might fail
[] t=2 -> (t'=4); // try GSM to locate user
[] t=3 -> (t'=3); // phone failure -> loop to end model
[] t=4 -> (1-gsm_fail):(t'=5) + gsm_fail:(t'=6); //GSM localisation might fail
[] t=5 -> (t'=11); //localisation was successfull
[] t=6 -> (1-wifi_fail):(t'=7) + wifi_fail:(t'=8); //no GSM data, try Wi-Fi to locate user
[] t=7 -> (t'=11); //Wi-Fi localisation successfull
[] t=8 -> (1-gps_fail):(t'=9) + gps_fail:(t'=10); //no Wi-Fi data, try GPS to locate user
[] t=9 -> (t'=11); //localisation sucessfull
[] t=10 -> (t'=12); //no location data available
[] t=11 -> (t'=0); //localisation successfull, go back to start, t=0
[] t=12 -> (t'=12); //localisation failure, loop

endmodule


module User

//model user behaviour in check-in, travel and check-out mode
//u=0:init, u=1:user start application, u=2:user check-in, u=3:forget check-in, u=4:travel mode, u=5:check-out, u=6:recieve ticket, u=7:lose application

u:[0..7] init 0;

[] u=0 -> (u'=1); //start application
[] u=1 -> (1-no_checkin):(u'=2) + no_checkin:(u'=3); //user might forget to check-in
[] u=3 -> (u'=3); //user not checked in, terminate with loop
[] u=2 -> (u'=4); //user reaches travel mode after check-in
[] u=4 & !p=end_user -> (u'=4); //user hasn't reached end of journey and stays in travel mode
[] u=4 & p=end_user -> (u'=5); //user reached end of route and checks out
[] u=5 -> (u'=6); //user checked out and recieves ticket
[] u=6 -> (u'=7); //user is done using application
[] u=7 -> (u'=7); //loop to end

endmodule


module Zone1

//model user traveling through zone 1, to find out if zone gets recorded by ticketing system
//z1=0:start, z1=1:localisation in previous zone, z1=2:localisation in zone 1, z1=3:no localisation in zone 1, z1=4:end

z1:[0..4] init 0;

[] z1=0 & p=start_zone1-1 -> (z1'=1); //localisaiton before zone starts
[] z1=1 & p=start_zone1 -> (z1'=2); //first localistation in zone
[] p=end_zone1 -> (z1'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z1=1 | z1=2) & p=(start_zone1 + 1) -> (z1'=2); //user is located in zone
[] p=end_zone1 -> (z1'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z1=1 | z1=2) & p=(start_zone1 + 2) -> (z1'=2); //user is located in zone
[] p=end_zone1 -> (z1'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z1=1 | z1=2) & p=(start_zone1 + 3) -> (z1'=2); //user is located in zone
[] p=end_zone1 -> (z1'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z1=1 | z1=2) & p=(start_zone1 + 4) -> (z1'=2); //user is located in zone
[] p=end_zone1 -> (z1'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] z1=1 & p=(end_zone1 + 1) -> (z1'=3); //user was never in zone
[] z1=3 -> (z1'=4); // end of module

endmodule


module Zone2

//same as zone 1

z2:[0..4] init 0;

[] z2=0 & p=start_zone2 -1 -> (z2'=1); //localisaiton before zone starts
[] z2=1 & p=start_zone2 -> (z2'=2); //first localistation in zone
[] p=end_zone2 -> (z2'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z2=1 | z2=2) & p=(start_zone2 + 1)-> (z2'=2); //user is located in zone
[] p=end_zone2 -> (z2'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z2=1 | z2=2) & p=(start_zone2 + 2) -> (z2'=2); //user is located in zone
[] p=end_zone2 -> (z2'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z2=1 | z2=2) & p=(start_zone2 + 3) -> (z2'=2); //user is located in zone
[] p=end_zone2 -> (z2'=4); // heck if user reached end of the zone, if yes move to end of module z=4
[] (z2=1 | z2=2) & p=(start_zone2 + 4) -> (z2'=2); //user is located in zone
[] p=end_zone2 -> (z2'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] z2=1 & p=(end_zone2 + 1) -> (z2'=3); //user was never in zone
[] z2=3 -> (z2'=4); //end of module

endmodule


module Zone3

//same as zone 1

z3:[0..4] init 0;

[] z3=0 & p=start_zone3-1 -> (z3'=1); //localisaiton before zone starts
[] z3=1 & p=start_zone3 -> (z3'=2); //first localistation in zone
[] p=end_zone3 -> (z3'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z3=1 | z3=2) & p=(start_zone3 + 1) -> (z3'=2); //user is located in zone
[] p=end_zone3 -> (z3'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z3=1 | z3=2) & p=(start_zone3 + 2) -> (z3'=2); //user is located in zone
[] p=end_zone3 -> (z3'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z3=1 | z3=2) & p=(start_zone3 + 3)-> (z3'=2); //user is located in zone
[] p=end_zone3 -> (z3'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] (z3=1 | z3=2) & p=(start_zone3 + 4) -> (z3'=2); //user is located in zone
[] p=end_zone3 -> (z3'=4); //check if user reached end of the zone, if yes move to end of module z=4
[] z3=1 & p=(end_zone3 + 1) -> (z3'=3); //user was never in zone
[] z3=3 -> (z3'=4); //end of module

endmodule


//rewards

//reward to count how many times ticketing system tried to get users location
rewards
[get_u_pos] true: 1;
endrewards
