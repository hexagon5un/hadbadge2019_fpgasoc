#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#include "mach_defines.h"
#include "gfx_load.h"
#include "cache.h"
#include "midi_note_increments.h"
#include "Tetris-Theme_A_by_Gori_Fater.h"
#include "Mario-Sheet-Music-Overworld-Main-Theme.h"

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

void main(int argc, char **argv)
{
	int delta, voice, note;
	int gates = 0;

	synth_regs->samplerate_div = (1000 - 2);	/* 48M / 1000 = 48 kHz */
	synth_regs->volume = 255;			/* Max volume */

	for (int j=0; j<8; j++) {
		/* synth_regs->voice[j].ctrl     = SYNTH_VOICE_CTRL_ENABLE | ((j%3) << 2); */
		synth_regs->voice[j].ctrl     = SYNTH_VOICE_CTRL_ENABLE | SYNTH_VOICE_CTRL_SAWTOOTH	;
		synth_regs->voice[j].volume   = SYNTH_VOICE_VOLUME(192,192);
		synth_regs->voice[j].duration = 46; /* ~ 250 ms */
		synth_regs->voice[j].attack   = 0x0020;
		synth_regs->voice[j].decay    = 0x0040;
		/* synth_regs->voice[j].phase_cmp=  (1<<9); */
		synth_regs->voice[j].phase_inc = midi_table[20 + scale_major(j)];
	}

	for (int event=0; event < 469; ++event){
	/* for (int event=0; event < 3552; ++event){ */
		delta = tetris[event][0];
		voice = tetris[event][1];
		note  = tetris[event][2];
		pause(480*delta);

		if (note < 128){ // range valid midi notes
			synth_regs->voice[voice].phase_inc = midi_table[note-24];
			gates |= (1 << voice);
		}
		else {
			gates &= ~(1 << voice);
		}
		synth_regs->voice_force = gates;
	}

	synth_regs->voice_force = 0;
}
