%pilot(name).
pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

%pilot_team(pilot_name, team_name).
pilot_team('Lamb', 'Breitling').
pilot_team('Besenyei', 'Red Bull').
pilot_team('Chambliss', 'Red Bull').
pilot_team('MacLean', ' Mediterranean Racing Team').
pilot_team('Manglod', 'Cobra').
pilot_team('Jones', 'Matador').
pilot_team('Bonhomme', 'Matador').

%pilot_plane(pilot_name, plane_name).
pilot_plane('Lamb', 'MX2').
pilot_plane('Besenyei', 'Edge540'). 
pilot_plane('Chambliss', 'Edge540').  
pilot_plane('MacLean', 'Edge540').
pilot_plane('Mangold', 'Edge540').
pilot_plane('Jones', 'Edge540'). 
pilot_plane('Bonhomme', 'Edge540').

%circuit(city).
circuit('Istanbul').
circuit('Budapest').
circuit('Porto').

%won_circuit(pilot_name, city).
won_circuit('Jones', 'Porto').
won_circuit('Mangold', 'Budapest').
won_circuit('Mangold', 'Istanbul').

%circuit_gates(city, number_gates).
circuit_gates('Istanbul', 9).
circuit_gates('Budapest', 6).
circuit_gates('Porto', 5).

%team_won_race(Team_name, Circuit_city).
team_won_race(Team, Circuit) :-
    pilot_team(Pilot, Team),
    won_circuit(Pilot, Circuit).

%won_many_circuits(Pilot_name).
won_many_circuits(Pilot) :-
    won_circuit(Pilot, C1),
    won_circuit(Pilot, C2),
    circuit(C1),
    circuit(C2),
    C1 \= C2.

%big_circuit(Circuit_city).
big_circuit(Circuit) :-
    circuit(Circuit),
    circuit_gates(Circuit, Gates),
    Gates > 8.

%not_pilot_edge540(Pilot_name).
not_pilot_edge540(Pilot) :-
    pilot(Pilot),
    \+ pilot_plane(Pilot, 'Edge540').

/*
a)won_circuit(Pilot, 'Porto').
b)team_won_race(Team, 'Porto').
c)won_many_circuits(Pilot).
d)big_circuit(Circuit).
e)not_pilot_edge540(Pilot).
*/