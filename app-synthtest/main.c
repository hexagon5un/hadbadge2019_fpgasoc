#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#include "mach_defines.h"
#include "gfx_load.h"
#include "cache.h"


#define SYNTH_VOICE_CTRL_ENABLE		(1 << 0)
#define SYNTH_VOICE_CTRL_PHASE_ZERO	(1 << 1)
#define SYNTH_VOICE_CTRL_SAWTOOTH	(0 << 2)
#define SYNTH_VOICE_CTRL_TRIANGLE	(1 << 2)
#define SYNTH_VOICE_CTRL_PULSE		(2 << 2)
#define SYNTH_VOICE_CTRL_SUBHARMONIC	(3 << 2)
#define SYNTH_VOICE_CTRL_WT4K_FWD	(4 << 2)
#define SYNTH_VOICE_CTRL_WT4K_FWD_REV	(5 << 2)
#define SYNTH_VOICE_CTRL_WT2K_FWD	(6 << 2)
#define SYNTH_VOICE_CTRL_WT2K_FWD_REV	(7 << 2)

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

static volatile uint32_t * const synth_wt = (void*)(AUDIO_CORE_BASE | 0x00030000);



static inline void
pause(uint32_t duration){
	for (volatile uint32_t i=0; i<duration; i++){;}
}
#define SHORT    0x00040000
#define MIDDLE   0x00080000
#define LONG     0x00100000




void
main(int argc, char **argv)
{
	synth_regs->samplerate_div = (1000 - 2);	/* 48M / 1000 = 48 kHz */
	synth_regs->volume = 255;			/* Max volume */

	synth_regs->voice[0].ctrl     = SYNTH_VOICE_CTRL_ENABLE | SYNTH_VOICE_CTRL_TRIANGLE;
	synth_regs->voice[0].volume   = SYNTH_VOICE_VOLUME(192, 192);
	synth_regs->voice[0].duration = 46; /* ~ 250 ms */
	synth_regs->voice[0].attack   = 0x1040;
	synth_regs->voice[0].decay    = 0x1040;

	while (1) {
		for (int i=0; i<65536; i+=4096) {
			synth_regs->voice[0].phase_inc = i;
			synth_regs->voice_start = 0x0001;
			pause(MIDDLE);
		}
	}
}

