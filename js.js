   var z1_size;
   var z2_size;
   var z3_size;
   var model_name;
   var z1_start;
   var z1_end;
   var z2_start;
   var z2_end;
   var z3_start;
   var z3_end;

   //get user input and run prism
    function RunFile() {
    //get user input
    z1_size = document.getElementById('zone1').value;
    z2_size = document.getElementById('zone2').value;
    z3_size = document.getElementById('zone3').value;
    var phone_f = document.getElementById('phone_failure').value;
    var ci_f = document.getElementById('ci_failure').value;
    var gsm_f = document.getElementById('gsm_failure').value;
    var wifi_f = document.getElementById('wifi_failure').value;
    var gps_f = document.getElementById('gps_failure').value;

    //convert to percentage
    phone_f = phone_f/100;
    ci_fi = ci_f/100;
    gsm_f = gsm_f/100;
    wifi_f = wifi_f/100;
    gps_f = gps_f/100;

    //set start and end points of zones
    getZones();

    //parse user input to string
    var phone_f_s = phone_f.toString();
    var ci_f_s = ci_fi.toString();
    var gsm_f_s = gsm_f.toString();
    var wifi_f_s = wifi_f.toString();
    var gps_f_s =  gps_f.toString();

    //crate string to run prism
    var run_prism = "prism model-var.pm properties.pctl -const phone_fail_input=" + phone_f_s + ",no_checkin=" + ci_f_s + ",gsm_fail=" + gsm_f_s + ",wifi_fail=" + wifi_f_s + ",gps_fail=" + gps_f_s + ",start_zone1=" + z1_start + ",end_zone1=" + z1_end + ",start_zone2=" + z2_start + ",end_zone2=" + z2_end + ",start_zone3=" + z3_start + ",end_zone3=" + z3_end + ",a=0.2:0.05:1 -exportresults ../../../Users/c.gassmann/Desktop/results.txt";
   
    //test command sent to prism
    //alert(run_prism);

    //run prism using command line
    WshShell = new ActiveXObject("WScript.Shell");
    WshShell.Run(run_prism);
  	}

  	//open notepad with results
  	function openResult() {
  		WshShell = new ActiveXObject("WScript.Shell");
  		WshShell.Run("notepad C:/Users/c.gassmann/Desktop/results.txt");
    }

    //function to calculate starting and end positions for each of the three zones.
    function getZones() {
    	var lengthz1;
    	var lengthz2;
    	var lengthz3;

    	//get lenght for zone 1
    	if (z1_size == "s") {
    		lengthz1 = 0;
    	}
    	else if (z1_size == "m") {
    		lengthz1 = 2;
    	}
    	else {
    		lengthz1 = 5;
    	}

    	//get lenght for zone 2
    	if (z2_size == "s") {
    		lengthz2 = 0;
    	}
    	else if (z2_size == "m") {
    		lengthz2 = 2;
    	}
    	else {
    		lengthz2 = 5;
    	}


    	//get lenght for zone 3
    	if (z3_size == "s") {
    		lengthz3 = 0;
    	}
    	else if (z3_size == "m") {
    		lengthz3 = 2;
    	}
    	else {
    		lengthz3 = 5;
    	}


    	//set starting and ending poisitions for all three zones
    	z1_start = 2; //zone1 has always the same starting point
    	z1_end = z1_start + lengthz1;
    	z2_start = z1_end +1;
    	z2_end = z2_start + lengthz2;
    	z3_start = z2_end + 1;
    	z3_end = z3_start + lengthz3;
    }
