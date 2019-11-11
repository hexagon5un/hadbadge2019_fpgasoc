#include "libsynth.h"


// Bunch of defaults that render the synth engine immediately playable on any of the voices
// If you know what you want, you might not need this.  
// But if you just want something to start with, this ia a good bet.
// synth_init(4) will set you up with four triangle-wave voices.  Bam!
void synth_init(uint8_t numvoices){
	synth_regs->samplerate_div = (1000 - 2);	/* 48M / 1000 = 48 kHz */
	synth_regs->volume = 255;			/* Max volume */

	// Sensible defaults?
	for (uint8_t j=0; j<numvoices; j++) {
		synth_regs->voice[j].ctrl     = SYNTH_VOICE_CTRL_ENABLE | SYNTH_VOICE_CTRL_TRIANGLE;
		synth_regs->voice[j].volume   = SYNTH_VOICE_VOLUME(192,192);
		synth_regs->voice[j].duration = 46; /* ~ 250 ms */
		synth_regs->voice[j].attack   = 0x1040;
		synth_regs->voice[j].decay    = 0x1040;
		synth_regs->voice[j].phase_cmp=  (1<<9); // not relevant for sawtooth, but good to do
		synth_regs->voice[j].phase_inc = 5852; // middle C
	}
}


void synth_all_off(){
	synth_regs->voice_force = 0;	
}


