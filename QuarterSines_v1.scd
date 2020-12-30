MIDIClient.init;

MIDIIn.connectAll

/* nanoKontrol  */


~phaseSpec = [0.1, 300.0, \exp, 0.001].asSpec;
~indexSpec = [0.0, 100.0, \linear, 0.001].asSpec;


MIDIdef.new(\test1, {|val num chan dev|

	[num, val].postln;

	case
	{ num == 32 } { Ndef(\t).set(\phaseMod, ~phaseSpec.map(val/127) );  }
	{ num == 33 } { Ndef(\t).set(\index, ~indexSpec.map(val/127) );  }

}, nil, 1, \control, nil);





Ndef(\t, {|phaseMod=0.1 index=0.0|
	var f1, f2;
	var mod1, mod2, car;
	f1 = 359.61;
	f2 = 380.995;
	mod1 = SinOsc.ar(f1) * f1 * index;
	mod2 = SinOsc.ar(f2) * f2 * index;

	car = SinOsc.ar([f1 + mod1,f2 + mod2],
		SinOsc.kr(phaseMod,0,0.1).range(-2pi,2pi)!2,
		SinOsc.kr(LFNoise1.kr(0.8).range(0.001,0.25)).range(0.125,0.5)!2);

	Out.ar(0, car);

}).play;




Ndef(\t, {

	var sig = SinOsc.ar([127.14,134.7],0,SinOsc.kr(LFNoise1.kr(0.8).range(0.001,0.25)).range(0.125,0.5)!2);


	Out.ar(0, sig)


}).play;