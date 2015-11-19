/*
*
*	Author: Konrad Dryja
*	Func:
*		
*
*/
params[["_truck",objNull,[objNull]],["_chopper",objNull,[objNull]]];

_action = format ["
	_increment = 0;
	%1 enableSimulation false;
	%2 enableSimulation false;
	if(abs(getDir %1 - getDir %2) <180) then{
		_increment = -1;
	};
	if(abs(getDir %1 - getDir %2) >180) then{
		_increment = 1;
	};
	while {(getDir %1) != (getDir %2)} do
	{
		if((abs(getDir %1 - getDir %2)) <2) exitWith{
			%1 setDir(getDir %2);
		};
		%1 setDir (getDir %1 +_increment);
		
		sleep 0.02;
	};

	if((getPos %1 select 2) > (getPos %2 select 2)) then{
		_increment = 0.1;
		while {((getPos %2 select 2) - (getPos %1 select 2) + 2) > 0.2 } do
		{		
			%1 setPos [getPos %1 select 0, getPos %1 select 1, (getPos %1 select 2) + _increment];		
			sleep 0.07;
		};
	}
	else{
		_increment = -0.1;
		while {((getPos %1 select 2) - (getPos %2 select 2) + 10) > 1 } do
		{		
			%1 setPos [getPos %1 select 0, getPos %1 select 1, (getPos %1 select 2) + _increment];		
			sleep 0.07;
		};
	};
	

	if((getPos %1 select 0) > (getPos %2 select 0)) then{
		_increment = -0.1;
	}
	else{
		_increment = 0.1;
	};
	while {abs((getPos %1 select 0) - (getPos %2 select 0)) >0.15} do
	{
		if((abs((getPos %1 select 0) - (getPos %2 select 0))) <0.15) exitWith{
			%1 setPos[(getPos %2 select 0), getPos %1 select 1, getPos %1 select 2];
		};
		%1 setPos [(getPos %1 select 0) + _increment, getPos %1 select 1, getPos %1 select 2];
		
		sleep 0.07;
	};


	if((getPos %1 select 1) > (getPos %2 select 1)) then{
		_increment = -0.1;
	}
	else{
		_increment = 0.1;
	};
	while {abs((getPos %1 select 1) - (getPos %2 select 1)) >0.15  } do
	{		
		%1 setPos [getPos %1 select 0, (getPos %1 select 1) + _increment, getPos %1 select 2];	
		sleep 0.07;
	};
	%1 setPos [getPos %1 select 0, (getPos %2 select 1), getPos %1 select 2];
	%1 attachTo [%2, [0,-2.2,0.3], 'Hull'];
	%1 enableSimulation true;
	%2 enableSimulation true;
",_chopper,_truck];
_condition = format ["(count nearestObjects [%1, ['c_hatchback_01_f'], 10] > 0) && (isNull attachedTo %2)",_truck,_chopper];
_actiondLoad = _truck addAction [
	'Load the chopper',
	_action,
	nil,
	1.5,
	true,
	true,
	"",
	_condition
];
_action = format["
	detach %1;
	%1 setPos [((getPos (_this select 0)) select 0)+8, ((getPos (_this select 0)) select 1), (getPos (_this select 0)) select 2];
	", _chopper, _truck];
_condition = format ["!(isNull attachedTo %1)",_chopper];
_truck addAction [
	'Unload the chopper',
	_action,
	nil,
	1.5,
	true,
	true,
	"",
	_condition
];