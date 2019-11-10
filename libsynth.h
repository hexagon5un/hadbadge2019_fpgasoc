#pragma once

#include <stdint.h>
#include "mach_defines.h"

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

// Sets up numvoices to bland triangle waves
void synth_init(uint8_t numvoices);

// Turns all voices off, now.
void synth_all_off();
