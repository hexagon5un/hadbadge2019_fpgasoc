#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include "libsynth.h"
#include "midi_note_increments.h"

static inline void
pause(uint32_t duration){
	for (volatile uint32_t i=0; i<duration; i++){;}
}
#define SHORT    0x00040000
#define MIDDLE   0x00080000
#define LONG     0x00100000


int scale_major(int i){
	int scale_table_major[] = {0, 2, 4, 5, 7, 9, 11};
	return (i/7)*12 + scale_table_major[i%7];
}

// do I want an enum with all of the midi notes spelled out?  A3 A3# etc?
// Which Demo?
// SCALES, DEFAULTS, CHORDS, PWM, 
#define DEFAULTS 1
// #define PWM 1
#define SCALES 1
#define CHORDS 1

void main(int argc, char **argv)
{
	synth_now->samplerate_div = (1000 - 2);	/* 48M / 1000 = 48 kHz */
	synth_now->volume = 192;			/* Max volume */

#ifdef DEFAULTS
	for (int j=0; j<8; j++) {
		synth_now->voice[j].ctrl     = SYNTH_VOICE_CTRL_ENABLE | ((j%3) << 2);
		synth_now->voice[j].volume   = SYNTH_VOICE_VOLUME(192,192);
		synth_now->voice[j].duration = 46; /* ~ 250 ms */
		synth_now->voice[j].attack   = 0x1020;
		synth_now->voice[j].decay    = 0x1040;
		synth_now->voice[j].phase_cmp=  (1<<9);
		synth_now->voice[j].phase_inc = midi_table[20 + scale_major(j)];
	}
#endif

#ifdef SCALES
	for (int j=0; j<4; j++) {
		synth_now->voice[j].ctrl     = SYNTH_VOICE_CTRL_ENABLE | (j << 2);
		for (int i=0; i<8; i++) {
			synth_now->voice[j].phase_inc = midi_table[20 + scale_major(i)];
			synth_now->voice_start = (1 << j);
			pause(MIDDLE);
		}
	}
#endif

#ifdef CHORDS
	// quick chord
	synth_now->voice[0].phase_inc = midi_table[20];
	synth_now->voice[1].phase_inc = midi_table[24];
	synth_now->voice[2].phase_inc = midi_table[27];
	synth_now->voice[3].phase_inc = midi_table[32];
	synth_now->voice_start = 0x0F;
	pause(LONG); 
#endif

#ifdef PWM
	// pwm and force gate
	for (int j=0; j<4; j++) {
		synth_now->voice[j].attack   = 0x4040;
		synth_now->voice[j].decay   = 0x4040;
	}
	synth_now->voice_force	= 0x0F;
	pause(LONG);
	pause(LONG);
	synth_now->voice_force	= 0x00;
	pause(LONG);
	pause(LONG);
	pause(LONG);
	pause(LONG);
	pause(LONG);
	pause(LONG);
#endif

	synth_now->volume = 0;	
}

