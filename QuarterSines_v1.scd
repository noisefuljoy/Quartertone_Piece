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

1/2.8284534821497

369.99*0.4454444714722
196.00/369.99

// add voice like humming melody and then slowly fade in fm synthesis and make index higher along the way

r = Routine({ inf.do{
	               var imod;
	               var freq1, freq2, fmul;
	               f = [1,1,2,3,5,8,13,21,34,55,89,144,233];
	               g = [0.35355009594854, 0.4454444714722, 0.52974404713641, 1];
	               fmul = g.choose;
	               freq1 = 359.61 * fmul;
	               freq2 = 380.995 * fmul;

	              imod = f.choose;
	              Ndef(\t).set(\index,imod);
	              Ndef(\t).set(\f1,   freq1);
	              Ndef(\t).set(\f2,   freq2);
	              (imod * 0.01).wait;
}}).play;

r.stop;


Ndef(\t, {|phaseMod=0.1 index=0.0 f1 = 359.61 f2 = 380.995|

	var mod1, mod2, car;


	mod1 = SinOsc.ar(f1) * f1 * index;
	mod2 = SinOsc.ar(f2) * f2 * index;

	car = SinOsc.ar([f1 + mod1,f2 + mod2],
		SinOsc.kr(phaseMod,0,0.1).range(-2pi,2pi)!2,
		SinOsc.kr(LFNoise1.kr(0.8).range(0.001,0.25)).range(0.125,0.5)!2);

	car = FreeVerb2.ar(car[0],car[1], 0.4,0.8);

	Out.ar(0, car);

}).play;




Ndef(\t, {

	var sig = SinOsc.ar([127.14,134.7],0,SinOsc.kr(LFNoise1.kr(0.8).range(0.001,0.25)).range(0.125,0.5)!2);


	Out.ar(0, sig)


}).play;