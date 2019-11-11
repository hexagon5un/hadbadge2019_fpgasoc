#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#include "mach_defines.h"
#include "mach_interrupt.h"
#include "cache.h"


extern char _binary_test_raw_start;
extern char _binary_test_raw_end;


#define AUDIO_CSR_PCM_FULL		(1 << 31)
#define AUDIO_CSR_PCM_AFULL		(1 << 30)
#define AUDIO_CSR_PCM_AEMPTY		(1 << 29)
#define AUDIO_CSR_PCM_EMPTY		(1 << 28)

#define AUDIO_CSR_PCM_OVERFLOW		(1 << 27)
#define AUDIO_CSR_PCM_UNDERFLOW		(1 << 26)

#define AUDIO_CSR_SYNTH_CMD_FULL	(1 << 23)
#define AUDIO_CSR_SYNTH_CMD_AFULL	(1 << 22)
#define AUDIO_CSR_SYNTH_CMD_AEMPTY	(1 << 21)
#define AUDIO_CSR_SYNTH_CMD_EMPTY	(1 << 20)

#define AUDIO_CSR_SYNTH_CMD_OVERFLOW	(1 << 19)
#define AUDIO_CSR_SYNTH_EVT_OVERFLOW	(1 << 18)
#define AUDIO_CSR_SYNTH_EVT_FULL	(1 << 17)
#define AUDIO_CSR_SYNTH_EVT_EMPTY	(1 << 16)

#define AUDIO_CSR_IRQ_PCM_AFULL_N	(1 << 15)
#define AUDIO_CSR_IRQ_PCM_AEMPTY	(1 << 14)
#define AUDIO_CSR_IRQ_SYNTH_CMD_AFULL_N	(1 << 13)
#define AUDIO_CSR_IRQ_SYNTH_CMD_AEMPTY	(1 << 12)
#define AUDIO_CSR_IRQ_SYNTH_EVT_EMPTY_N	(1 << 11)

#define AUDIO_CSR_UNFORCE_DC_LEVEL	(1 <<  1)
#define AUDIO_CSR_FORCE_DC_LEVEL	(1 <<  0)

#define SYNTH_EVT_INVALID		(1 << 31)

#define PCM_CFG_ENABLE			(1 << 31)
#define PCM_CFG_DIV(d)			((d) << 16)
#define PCM_CFG_VOLUME(l,r)		(((l) << 8) | (r))

struct audio {
	uint32_t csr;
	uint32_t evt;
	uint32_t pcm_cfg;
	uint32_t pcm_data;
} __attribute__((packed,aligned(4)));


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
	uint32_t _rsvd[4];

	/* Commands (only valid for queuing !!!) */
	uint32_t cmd_wait;
	uint32_t cmd_gen_event;
} __attribute__((packed,aligned(4)));

static volatile struct audio * const audio_regs  = (void*)((AUDIO_CORE_BASE) + 0x00000);
static volatile uint32_t *     const synth_wt    = (void*)((AUDIO_CORE_BASE) + 0x10000);
static volatile struct synth * const synth_now   = (void*)((AUDIO_CORE_BASE) + 0x20000);
static volatile struct synth * const synth_queue = (void*)((AUDIO_CORE_BASE) + 0x30000);


#if 0
static void
queue_cycle(void)
{
	static int cnt = 0;

	/* We know the FIFO is large enough to contain it when we call this ...
	 * -> no need to check FULL / AFULL */
	for (int i=8192; i<65536; i+=8192) {
		synth_queue->voice[0].phase_inc = i;
		synth_queue->voice_start = 0x0001;
		synth_queue->cmd_wait = 30000;
	}
	synth_queue->cmd_gen_event = cnt++;
}

static mach_int_frame_t *
audio_interrupt_handler(mach_int_frame_t *frame, int int_no)
{
	uint32_t e;

	printf("Int %08x\n", audio_regs->csr);

	while (((e = audio_regs->evt) & SYNTH_EVT_INVALID) == 0)
	{
		printf(" .evt %d\n", e);
		queue_cycle();
	}

	return frame;
}


void
main(int argc, char **argv)
{
	synth_now->samplerate_div = (1000 - 2);	/* 48m / 1000 = 48 khz */
	synth_now->volume = 255;			/* max volume */

	synth_now->voice[0].ctrl     = SYNTH_VOICE_CTRL_ENABLE | SYNTH_VOICE_CTRL_TRIANGLE;
	synth_now->voice[0].volume   = SYNTH_VOICE_VOLUME(192, 192);
	synth_now->voice[0].duration = 46; /* ~ 250 ms */
	synth_now->voice[0].attack   = 0x1040;
	synth_now->voice[0].decay    = 0x1040;

	/* queue cycle twice */
	for (int j=0; j<2; j++)
		queue_cycle();

	/* enable interrupts */
	printf("audio csr pre %08x\n", audio_regs->csr);
	audio_regs->csr = (audio_regs->csr & 0xffff0000) | AUDIO_CSR_IRQ_SYNTH_EVT_EMPTY_N;	/* clear all conditions and enable interrupt */
	printf("audio csr post %08x\n", audio_regs->csr);
	mach_set_int_handler(INT_NO_AUDIO, audio_interrupt_handler);
	mach_int_ena(1 << INT_NO_AUDIO);

	/* done */
	while (1);
}
#endif


static uint16_t *p = (void*)&_binary_test_raw_start;

static void
pcm_fill(void)
{
	/* An assembly optimized loop would make sense here in a real game, but this
	 * is a demo ... */

	uint16_t *e = (void*)&_binary_test_raw_end;
	int n = e - p;

	while (n) {
		/* Check for AFULL */
		if (audio_regs->csr & AUDIO_CSR_PCM_AFULL)
			break;

		/* Fill up to 32 samples */
		for (int i=0; i<32 && n; i++,n--)
			audio_regs->pcm_data = *p++;
	}

	if (n == 0) {
		p = (void*)&_binary_test_raw_start;
		pcm_fill();
	}
}

static mach_int_frame_t *
audio_interrupt_handler(mach_int_frame_t *frame, int int_no)
{
	uint32_t csr;

	csr = audio_regs->csr;

	//printf("Int %08x\n", csr);

	if (csr & AUDIO_CSR_PCM_UNDERFLOW) {
		audio_regs->csr = AUDIO_CSR_PCM_UNDERFLOW;
		printf("Underflow\n");
	}

	if (csr & AUDIO_CSR_PCM_EMPTY)
		printf("Empty\n");

	if (csr & AUDIO_CSR_PCM_AEMPTY)
		pcm_fill();

	return frame;
}

void
main(int argc, char **argv)
{
	/* Pre-fill PCM */
	pcm_fill();

	/* enable interrupts */
	printf("audio csr pre %08x\n", audio_regs->csr);
	audio_regs->csr = (audio_regs->csr & 0xffff0000) | AUDIO_CSR_IRQ_PCM_AEMPTY;	/* clear all conditions and enable interrupt */
	printf("audio csr post %08x\n", audio_regs->csr);
	mach_set_int_handler(INT_NO_AUDIO, audio_interrupt_handler);
	mach_int_ena(1 << INT_NO_AUDIO);

	/* configure and enable pcm */
	audio_regs->pcm_cfg = PCM_CFG_ENABLE | PCM_CFG_DIV(3000-2) | PCM_CFG_VOLUME(128, 128);

	/* done */
	while (1);
}
