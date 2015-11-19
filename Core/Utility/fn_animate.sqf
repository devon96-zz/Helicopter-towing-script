truck = myTruck;
chopper = myChopper;
truck addAction ["wee", { 
	_increment = 0;
	chopper enableSimulation false;
	truck enableSimulation false;
	if(abs(getDir chopper - getDir truck) <180) then{
		_increment = -1;
	};
	if(abs(getDir chopper - getDir truck) >180) then{
		_increment = 1;
	};
	while {(getDir chopper) != (getDir truck)} do
	{
		if((abs(getDir chopper - getDir truck)) <2) exitWith{
			chopper setDir(getDir truck);
		};
		chopper setDir (getDir chopper +_increment);
		
		sleep 0.02;
	};

	if((getPos chopper select 2) > (getPos truck select 2)) then{
		_increment = 0.2;
	}
	else{
		_increment = -0.2;
	};
	while {abs((getPos chopper select 2) - (getPos truck select 2)) < 2  } do
	{		
		chopper setPos [getPos chopper select 0, getPos chopper select 1, (getPos chopper select 2) + _increment];		
		sleep 0.2;
	};

	if((getPos chopper select 0) > (getPos truck select 0)) then{
		_increment = -0.2;
	}
	else{
		_increment = 0.2;
	};
	while {(getPos chopper select 0) != (getPos truck select 0)} do
	{
		if((abs((getPos chopper select 0) - (getPos truck select 0))) <2) exitWith{
			chopper setPos[(getPos truck select 0), getPos chopper select 1, getPos chopper select 2];
		};
		chopper setPos [(getPos chopper select 0) + _increment, getPos chopper select 1, getPos chopper select 2];
		
		sleep 0.2;
	};


	if((getPos chopper select 1) > (getPos truck select 1)) then{
		_increment = -0.2;
	}
	else{
		_increment = 0.2;
	};
	while {abs((getPos chopper select 1) - (getPos truck select 1)) >3  } do
	{		
		chopper setPos [getPos chopper select 0, (getPos chopper select 1) + _increment, getPos chopper select 2];	
		sleep 0.2;
	};
	chopper attachTo [truck, [0,-2.2,0.3], 'Hull'];
	chopper enableSimulation true;
	truck enableSimulation true;
}];