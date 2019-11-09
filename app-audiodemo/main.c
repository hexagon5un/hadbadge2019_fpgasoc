#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#include "mach_defines.h"
#include "gfx_load.h"
#include "cache.h"
#include "midi_note_increments.h"

#define SYNTH_VOICE_CTRL_ENABLE		(1 << 0)
#define SYNTH_VOICE_CTRL_PHASE_ZERO	(1 << 1)
#define SYNTH_VOICE_CTRL_SAWTOOTH	(0 << 2)
#define SYNTH_VOICE_CTRL_TRIANGLE	(1 << 2)
#define SYNTH_VOICE_CTRL_PULSE		(2 << 2)
#define SYNTH_VOICE_CTRL_SUBHARMONIC	(3 << 2)

#define SYNTH_VOICE_VOLUME(l,r)		(((l)<<8) | (r))

struct synth {
	/* Per-Voice registers */
	struct {
		uint32_t ctrl;
		uint32_t _rsvd;
		uint32_t phase_inc;
		uint32_t phase_cmp;
		uint32_t volume;
		uint32_t duration;
		uint32_t attack;
		uint32_t decay;
	} voice[16];

	/* Global register */
	uint32_t samplerate_div;
	uint32_t volume;
	uint32_t voice_force;
	uint32_t voice_start;
} __attribute__((packed,aligned(4)));

static volatile struct synth * const synth_regs = (void*)(AUDIO_CORE_BASE);

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
#define PWM 1

void main(int argc, char **argv)
{
	synth_regs->samplerate_div = (1000 - 2);	/* 48M / 1000 = 48 kHz */
	synth_regs->volume = 255;			/* Max volume */

#ifdef DEFAULTS
	for (int j=0; j<8; j++) {
		synth_regs->voice[j].ctrl     = SYNTH_VOICE_CTRL_ENABLE | ((j%3) << 2);
		synth_regs->voice[j].volume   = SYNTH_VOICE_VOLUME(192,192);
		synth_regs->voice[j].duration = 46; /* ~ 250 ms */
		synth_regs->voice[j].attack   = 0x1020;
		synth_regs->voice[j].decay    = 0x1040;
		synth_regs->voice[j].phase_cmp=  (1<<9);
		synth_regs->voice[j].phase_inc = midi_table[20 + scale_major(j)];
	}
#endif

#ifdef SCALES
	for (int j=0; j<4; j++) {
		synth_regs->voice[j].ctrl     = SYNTH_VOICE_CTRL_ENABLE | (j << 2);
		for (int i=0; i<8; i++) {
			synth_regs->voice[j].phase_inc = midi_table[20 + scale_major(i)];
			synth_regs->voice_start = (1 << j);
			pause(MIDDLE);
		}
	}
#endif

#ifdef CHORDS
	// quick chord
	synth_regs->voice[0].phase_inc = midi_table[20];
	synth_regs->voice[1].phase_inc = midi_table[24];
	synth_regs->voice[2].phase_inc = midi_table[27];
	synth_regs->voice[3].phase_inc = midi_table[32];
	synth_regs->voice_start = 0x0F;
	pause(LONG); 
#endif

#ifdef PWM
	// pwm and force gate
	for (int j=0; j<4; j++) {
		synth_regs->voice[j].attack   = 0x4040;
		synth_regs->voice[j].decay   = 0x4040;
	}
	synth_regs->voice_force	= 0x0F;
	pause(LONG);
	pause(LONG);
	synth_regs->voice_force	= 0x00;
	pause(LONG);
	pause(LONG);
	pause(LONG);
	pause(LONG);
	pause(LONG);
	pause(LONG);
#endif

	synth_regs->volume = 0;	
}

