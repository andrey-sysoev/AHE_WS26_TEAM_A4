#include "xil_io.h"
#include "xparameters.h"
#include "sleep.h"
#define GPIO0_BASE 0x40000000

#define GPIO_SW  0x00
#define GPIO_LED 0x08
#define GPIO1_BASE 0x40010000

#define SEG_REG 0x00
#define AN_REG  0x08

#define PWM_BASE 0x44A00000

#define PWM_CTRL 0x00
#define PWM_R    0x04
#define PWM_G    0x08
#define PWM_B    0x0C

static const u8 seg[16] = {
    0xC0, 0xF9, 0xA4, 0xB0,
    0x99, 0x92, 0x82, 0xF8,
    0x80, 0x90, 0x88, 0x83,
    0xC6, 0xA1, 0x86, 0x8E
};

void show_hex(u16 v)
{
    for (int d = 0; d < 4; d++)
    {
        u32 nib = (v >> (4 * d)) & 0xF;

        Xil_Out32(GPIO1_BASE + AN_REG, 0xFF);
        Xil_Out32(GPIO1_BASE + SEG_REG, seg[nib]);
        Xil_Out32(GPIO1_BASE + AN_REG, ~(1u << d) & 0xFF);

        usleep(1000);
    }
}

void pwm_fade(void)
{
    Xil_Out32(PWM_BASE + PWM_CTRL, 1);
    Xil_Out32(PWM_BASE + PWM_B, 128);

    for (int v = 0; v < 256; v++)
    {
        Xil_Out32(PWM_BASE + PWM_R, v);
        Xil_Out32(PWM_BASE + PWM_G, 255 - v);

        usleep(5000);
    }
}

int main(void)
{
    Xil_Out32(GPIO1_BASE + 0x04, 0x00);
    Xil_Out32(GPIO1_BASE + 0x0C, 0x00);

    Xil_Out32(PWM_BASE + PWM_CTRL, 1);

    while (1)
    {
        u32 sw = Xil_In32(GPIO0_BASE + GPIO_SW) & 0xFFFF;

        Xil_Out32(GPIO0_BASE + GPIO_LED, sw);

        Xil_Out32(PWM_BASE + PWM_R, ((sw >> 0) & 0xF) * 17);
        Xil_Out32(PWM_BASE + PWM_G, ((sw >> 4) & 0xF) * 17);
        Xil_Out32(PWM_BASE + PWM_B, ((sw >> 8) & 0xF) * 17);

        show_hex(sw);
    }

    return 0;
}